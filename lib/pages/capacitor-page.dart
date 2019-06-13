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

  calcula() {
    FrequenciaCorte f = new FrequenciaCorte();
    f.resistor =
        math.pow(10, potResistor1) * u.isNull(frequenciaCorte.resistor, 0.0);
    f.resistor2 =
        math.pow(10, potResistor2) * u.isNull(frequenciaCorte.resistor2, 0.0);
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
                  nivel == Nivel.ALTA
                      ? new Text("Resistor2(R2):")
                      : new Container(height: 0),
                  nivel == Nivel.ALTA
                      ? new TextField(
                          onChanged: (v) {
                            frequenciaCorte.resistor2 = double.parse(v);
                          },
                        )
                      : new Container(height: 0),
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
                      nivel == Nivel.ALTA
                          ? new Text("Resistor2: ")
                          : new Container(height: 0),
                      nivel == Nivel.ALTA
                          ? new Expanded(
                              child: new DropdownButton(
                              value: potFrequencia,
                              items: Utils.getDropDownMenuItems(),
                              onChanged: (t) {
                                this.setState(() {
                                  potResistor2 = t;
                                });
                              },
                            ))
                          : new Container(height: 0),
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
                      textScaleFactor: 2),
                  nivel == Nivel.BAIXA
                      ? new Text("Capacitor2:", textScaleFactor: 2)
                      : new Container(height: 0),
                  nivel == Nivel.BAIXA
                      ? new Text(
                          frequenciaCorte.capacitor2 == null
                              ? '0'
                              : frequenciaCorte.capacitor2.toString(),
                          textScaleFactor: 2)
                      : new Container(height: 0),
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (this.frequenciaCorte.resistor != null &&
              this.frequenciaCorte.resistor2 != null &&
              this.frequenciaCorte.frequencia != null) {
            setState(() {
              print(widget.escolha().toString());
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
