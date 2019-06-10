import 'package:calculo/model/frequencia-corte.dart';
import 'package:calculo/service/capacitor-service.dart';
import 'package:calculo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CapacitorPage extends StatefulWidget {
  CapacitorPage({Key key}) : super(key: key);

  @override
  _CapacitorPageState createState() => _CapacitorPageState();
}

class _CapacitorPageState extends State<CapacitorPage> {
  FrequenciaCorte frequenciaCorte = new FrequenciaCorte();
  CapacitorService cs = new CapacitorService();
  num potFrequencia = 0.0;
  num potResistor1 = 0.0;
  num potResistor2 = 0.0;

  calcula() {
    FrequenciaCorte f = new FrequenciaCorte();
    f.resistor = math.pow(10, potResistor1) * frequenciaCorte.resistor;
    f.resistor2 = math.pow(10, potResistor2) * frequenciaCorte.resistor2;
    f.frequencia = math.pow(10, potFrequencia) * frequenciaCorte.frequencia;
    frequenciaCorte.capacitor = cs.calcular(f).capacitor;
    f = new FrequenciaCorte();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capacitor'),
      ),
      body: new SingleChildScrollView(
          child: new Padding(
              padding: const EdgeInsets.all(30.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("Resistor1(R1):"),
                  new TextField(
                    onChanged: (v) {
                      frequenciaCorte.resistor = double.parse(v);
                    },
                  ),
                  new Text("Resistor2(R2):"),
                  new TextField(
                    onChanged: (v) {
                      frequenciaCorte.resistor2 = double.parse(v);
                    },
                  ),
                  new Text("Frequencia de Corte(FC):"),
                  new TextField(
                    onChanged: (v) {
                      frequenciaCorte.frequencia = double.parse(v);
                    },
                  ),
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                      textScaleFactor: 2),
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (this.frequenciaCorte.resistor != null &&
              this.frequenciaCorte.resistor2 != null &&
              this.frequenciaCorte.frequencia != null) {
            setState(() {
              this.calcula();
            });
          }
        },
        tooltip: 'CALCULAR',
        child: new Icon(Icons.border_color),
      ),
    );
  }
}
