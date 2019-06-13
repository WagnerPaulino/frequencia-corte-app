import 'package:calculo/enums/niveis.dart';
import 'package:calculo/model/frequencia-corte.dart';
import 'package:calculo/service/resistor-service.dart';
import 'package:calculo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../main.dart';

class ResistorPage extends StatefulWidget {
  ResistorPage({Key key, this.escolha}) : super(key: key);
  Function escolha;
  @override
  _ResistorPageState createState() => _ResistorPageState();
}

class _ResistorPageState extends State<ResistorPage> {
  FrequenciaCorte frequenciaCorte = new FrequenciaCorte();
  ResistorService rs = new ResistorService();
  Utils u = new Utils();

  num potFrequencia = 0.0;
  num potCapacitor = 0.0;
  num potCapacitor2 = 0.0;
  calcula() {
    FrequenciaCorte f = new FrequenciaCorte();
    f.capacitor =
        math.pow(10, potCapacitor) * u.isNull(frequenciaCorte.capacitor, 0.0);
    f.capacitor2 =
        math.pow(10, potCapacitor2) * u.isNull(frequenciaCorte.capacitor2, 0.0);
    f.frequencia =
        math.pow(10, potFrequencia) * u.isNull(frequenciaCorte.frequencia, 0.0);
    frequenciaCorte.resistor = rs.calcular(f, widget.escolha()).resistor;
    frequenciaCorte.resistor2 = rs.calcular(f, widget.escolha()).resistor2;
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
                  //Capacitor
                  new Text("Capacitor:"),
                  new TextField(
                    onChanged: (v) {
                      frequenciaCorte.capacitor = double.parse(v);
                    },
                  ),
                  //Capacitor2
                  nivel == Nivel.BAIXA
                      ? new Text("Capacitor:2")
                      : new Container(height: 0),
                  nivel == Nivel.BAIXA
                      ? new TextField(
                          onChanged: (v) {
                            frequenciaCorte.capacitor2 = double.parse(v);
                          },
                        )
                      : new Container(height: 0),
                  //Frequencia
                  new Text("Frequencia de Corte:"),
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
                      //Capacitor
                      new Text("Capacitor: "),
                      new Expanded(
                          child: new DropdownButton(
                        value: potCapacitor,
                        items: Utils.getDropDownMenuItems(),
                        onChanged: (t) {
                          this.setState(() {
                            potCapacitor = t;
                          });
                        },
                      )),
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
                      ))
                    ],
                  ),
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Capacitor2
                      nivel == Nivel.BAIXA
                          ? new Text("Capacitor2: ")
                          : new Container(height: 0),
                      nivel == Nivel.BAIXA
                          ? new Expanded(
                              child: new DropdownButton(
                              value: potCapacitor2,
                              items: Utils.getDropDownMenuItems(),
                              onChanged: (t) {
                                this.setState(() {
                                  potCapacitor2 = t;
                                });
                              },
                            ))
                          : new Container(height: 0),
                    ],
                  ),
                  new Text("Resistor 1:", textScaleFactor: 2),
                  new Text(
                      frequenciaCorte.resistor == null
                          ? '0'
                          : frequenciaCorte.resistor.toString(),
                      textScaleFactor: 2),
                  widget.escolha() == Nivel.ALTA
                      ? new Text("Resistor 2:", textScaleFactor: 2)
                      : new Container(height: 0),
                  widget.escolha() == Nivel.ALTA
                      ? new Text(
                          frequenciaCorte.resistor2 == null
                              ? '0'
                              : frequenciaCorte.resistor2.toString(),
                          textScaleFactor: 2)
                      : new Container(height: 0),
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (this.frequenciaCorte.capacitor != null &&
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
