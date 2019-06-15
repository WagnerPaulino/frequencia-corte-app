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
  final _formKey = GlobalKey<FormState>();
  FrequenciaCorte frequenciaCorteA = new FrequenciaCorte();
  FrequenciaCorte frequenciaCorteB = new FrequenciaCorte();
  FrequenciaCorte frequenciaCorte = new FrequenciaCorte();
  FrequenciaCorte frequenciaCorteR = new FrequenciaCorte();
  ResistorService rs = new ResistorService();
  Utils u = new Utils();

  num potFrequencia = 0.0;
  num potCapacitor = 0.0;
  num potResistor = 0.0;
  calcula() {
    FrequenciaCorte f = new FrequenciaCorte();
    if (widget.escolha() == Nivel.ALTA) {
      frequenciaCorte = frequenciaCorteA;
    } else {
      frequenciaCorte = frequenciaCorteB;
    }
    f.capacitor =
        math.pow(10, potCapacitor) * u.isNull(frequenciaCorte.capacitor, 0.0);
    f.resistor =
        math.pow(10, potResistor) * u.isNull(frequenciaCorte.resistor, 0.0);
    f.frequencia =
        math.pow(10, potFrequencia) * u.isNull(frequenciaCorte.frequencia, 0.0);
    frequenciaCorteR = rs.calcular(f, widget.escolha());
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
          child: Form(
              key: _formKey,
              child: new Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      widget.escolha() == Nivel.ALTA
                          ? new Text("Capacitor:")
                          : new Text("Resistor:"),
                      widget.escolha() == Nivel.ALTA
                          ? new TextFormField(
                              onSaved: (v) {
                                frequenciaCorteA.capacitor = double.parse(v);
                              },
                            )
                          : new TextFormField(
                              onSaved: (v) {
                                frequenciaCorteB.resistor = double.parse(v);
                              },
                            ),
                      new Text("Frequencia de Corte:"),
                      widget.escolha() == Nivel.ALTA
                          ? new TextFormField(
                              onSaved: (v) {
                                frequenciaCorteA.frequencia = double.parse(v);
                              },
                            )
                          : new TextFormField(
                              onSaved: (v) {
                                frequenciaCorteB.frequencia = double.parse(v);
                              },
                            ),
                      //Potencias
                      new Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          widget.escolha() == Nivel.ALTA
                              ? new Text("Capacitor: ")
                              : new Text("Resistor: "),
                          new Expanded(
                              child: new DropdownButton(
                            value: potCapacitor,
                            items: Utils.getDropDownMenuItems(),
                            onChanged: (t) {
                              this.setState(() {
                                widget.escolha() == Nivel.ALTA
                                    ? potCapacitor = t
                                    : potResistor = t;
                              });
                            },
                          )),
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
                      // Resultados
                      new Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[],
                      ),
                      widget.escolha() == Nivel.ALTA
                          ? new Text("Resistor 1:", textScaleFactor: 2)
                          : new Text("Capacitor 1:", textScaleFactor: 2),
                      new Text(
                          widget.escolha() == Nivel.ALTA
                              ? u
                                  .isNull(frequenciaCorteR.resistor, 0.0)
                                  .toString()
                              : u
                                  .isNull(frequenciaCorteR.capacitor, 0.0)
                                  .toString(),
                          textScaleFactor: 2),
                      widget.escolha() == Nivel.ALTA
                          ? new Text("Resistor 2:", textScaleFactor: 2)
                          : new Text("Capacitor 2:", textScaleFactor: 2),
                      new Text(
                          widget.escolha() == Nivel.ALTA
                              ? u
                                  .isNull(frequenciaCorteR.resistor2, 0.0)
                                  .toString()
                              : u
                                  .isNull(frequenciaCorteR.capacitor2, 0.0)
                                  .toString(),
                          textScaleFactor: 2)
                    ],
                  )))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            this._formKey.currentState.save();
            this.calcula();
            this._formKey.currentState.reset();
          });
        },
        tooltip: 'CALCULAR',
        child: new Icon(Icons.border_color),
      ),
    );
  }
}
