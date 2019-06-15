import 'package:calculo/enums/niveis.dart';
import 'package:calculo/main.dart';
import 'package:calculo/model/frequencia-corte.dart';
import 'package:calculo/service/capacitor-service.dart';
import 'package:calculo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CapacitorPage extends StatefulWidget {
  CapacitorPage({Key key, this.escolha}) : super(key: key);
  Function escolha;

  @override
  _CapacitorPageState createState() => _CapacitorPageState();
}

class _CapacitorPageState extends State<CapacitorPage> {
  FrequenciaCorte frequenciaCorte = new FrequenciaCorte();
  CapacitorService cs = new CapacitorService();
  Utils u = new Utils();
  num potFrequencia = 0.0;
  num potResistor1 = 0.0;
  num potResistor2 = 0.0;
  num potCapacitor1 = 0.0;
  num potCapacitor2 = 0.0;

  calcula() {
    FrequenciaCorte f = new FrequenciaCorte();
    f.resistor =
        math.pow(10, potResistor1) * u.isNull(frequenciaCorte.resistor, 0.0);
    f.resistor2 =
        math.pow(10, potResistor2) * u.isNull(frequenciaCorte.resistor2, 0.0);
    f.capacitor =
        math.pow(10, potCapacitor1) * u.isNull(frequenciaCorte.capacitor,0.0);
    f.capacitor2 =
        math.pow(10, potCapacitor2) * u.isNull(frequenciaCorte.capacitor2, 0.0);
    f.frequencia =
        math.pow(10, potFrequencia) * u.isNull(frequenciaCorte.frequencia, 0.0);
    frequenciaCorte.capacitor = cs.calcular(f, widget.escolha()).capacitor;
    frequenciaCorte.capacitor2 = cs.calcular(f, widget.escolha()).capacitor2;
    f = new FrequenciaCorte();
  }

  @override
  void initState() {
    callbacks = [];
    setCallback(this.setState);
    super.initState();
  }

  @override
  void dispose() {
    callbacks = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SingleChildScrollView(
          child: new Padding(
              padding: const EdgeInsets.all(30.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Resistor1
                  new Text("Resistor1(R1):"),
                  new TextField(
                    onChanged: (v) {
                      frequenciaCorte.resistor = double.parse(v);
                    },
                  ),
                  //Resistor2
                  new Text("Resistor2(R2):"),
                  new TextField(
                    onChanged: (v) {
                      frequenciaCorte.resistor2 = double.parse(v);
                    },
                  ),
                  //Frequencia
                  new Text("Frequencia de Corte(FC):"),
                  new TextField(
                    onChanged: (v) {
                      frequenciaCorte.frequencia = double.parse(v);
                    },
                  ),
                  //Potencias
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Resistor1
                      new Text("Resistor1: "),
                      new Expanded(
                          child: new DropdownButton(
                        value: potResistor1,
                        items: Utils.getDropDownMenuItems(),
                        onChanged: (t) {
                          this.setState(() {
                            potResistor1 = t;
                          });
                        },
                      )),
                      //Resistor2
                      new Text("Resistor2: "),
                      new Expanded(
                          child: new DropdownButton(
                        value: potFrequencia,
                        items: Utils.getDropDownMenuItems(),
                        onChanged: (t) {
                          this.setState(() {
                            potResistor2 = t;
                          });
                        },
                      )),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      //Frequencia
                      new Text("Frequencia: "),
                      new Expanded(
                          child: new DropdownButton(
                        value: potFrequencia,
                        items: Utils.getDropDownMenuItems(),
                        onChanged: (t) {
                          this.setState(() {
                            potFrequencia = t;
                          });
                        },
                      )),
                    ],
                  ),
                  new Text("Capacitor:", textScaleFactor: 2),
                  new Text(
                      frequenciaCorte.capacitor == null
                          ? '0'
                          : frequenciaCorte.capacitor.toString(),
                      textScaleFactor: 2)
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            this.calcula();
          });
        },
        tooltip: 'CALCULAR',
        child: new Icon(Icons.border_color),
      ),
    );
  }
}
