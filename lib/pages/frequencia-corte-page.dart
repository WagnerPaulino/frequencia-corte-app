import 'package:calculo/enums/niveis.dart';
import 'package:calculo/model/frequencia-corte.dart';
import 'package:calculo/service/frequenciaCorte-service.dart';
import 'package:calculo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../main.dart';

class FrequenciaCortePage extends StatefulWidget {
  FrequenciaCortePage({Key key, this.escolha}) : super(key: key);

  Function escolha;

  @override
  _FrequenciaCortePageState createState() => _FrequenciaCortePageState();
}

class _FrequenciaCortePageState extends State<FrequenciaCortePage> {
  FrequenciaCorteService fcs = new FrequenciaCorteService();
  FrequenciaCorte frequenciaCorte = new FrequenciaCorte();
  FrequenciaCorte frequenciaCorteA = new FrequenciaCorte();
  FrequenciaCorte frequenciaCorteB = new FrequenciaCorte();
  FrequenciaCorte frequenciaCorteR = new FrequenciaCorte();
  Utils u = new Utils();

  num potResistor1 = 0;
  num potCapacitor1 = 0;
  num potResistor2 = 0;
  num potCapacitor2 = 0;

  calcula() {
    if (widget.escolha() == Nivel.ALTA) {
      frequenciaCorte = frequenciaCorteA;
    } else {
      frequenciaCorte = frequenciaCorteB;
    }
    FrequenciaCorte f = new FrequenciaCorte();
    f.capacitor =
        math.pow(10, potCapacitor1) * u.isNull(frequenciaCorte.capacitor, 0.0);
    f.capacitor2 =
        math.pow(10, potCapacitor2) * u.isNull(frequenciaCorte.capacitor2, 0.0);
    f.resistor =
        math.pow(10, potResistor1) * u.isNull(frequenciaCorte.resistor, 0.0);
    f.resistor2 =
        math.pow(10, potResistor2) * u.isNull(frequenciaCorte.resistor2, 0.0);
    frequenciaCorteR = fcs.calcular(f, widget.escolha());
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.escolha() == Nivel.ALTA
                      ? new Text("Resistor1(R1): ", textScaleFactor: 1)
                      : new Text("Capacitor1(C1): ", textScaleFactor: 1),
                  widget.escolha() == Nivel.ALTA
                      ? new TextField(
                          onChanged: (t) {
                            frequenciaCorteA.resistor = double.parse(t);
                          },
                          onSubmitted: (a) {
                            print("s");
                          },
                          style: new TextStyle(
                              fontSize: 25.0, height: 1.0, color: Colors.black))
                      : new TextField(
                          onChanged: (t) {
                            frequenciaCorteB.capacitor = double.parse(t);
                          },
                          style: new TextStyle(
                              fontSize: 25.0,
                              height: 1.0,
                              color: Colors.black)),
                  widget.escolha() == Nivel.ALTA
                      ? new Text("Resistor2(R2): ", textScaleFactor: 1)
                      : new Text("Capacitor2(C2): ", textScaleFactor: 1),
                  widget.escolha() == Nivel.ALTA
                      ? new TextField(
                          onChanged: (t) {
                            frequenciaCorteA.resistor2 = double.parse(t);
                          },
                          style: new TextStyle(
                              fontSize: 25.0, height: 1.0, color: Colors.black))
                      : new TextField(
                          onChanged: (t) {
                            frequenciaCorteB.capacitor2 = double.parse(t);
                          },
                          style: new TextStyle(
                              fontSize: 25.0,
                              height: 1.0,
                              color: Colors.black)),
                  widget.escolha() == Nivel.ALTA
                      ? new Text("Capacitor: ", textScaleFactor: 1)
                      : new Text("Resistor: ", textScaleFactor: 1),
                  widget.escolha() == Nivel.ALTA
                      ? new TextField(
                          onChanged: (t) {
                            frequenciaCorteA.capacitor = double.parse(t);
                          },
                          style: new TextStyle(
                              fontSize: 25.0, height: 1.0, color: Colors.black))
                      : new TextField(
                          onChanged: (t) {
                            frequenciaCorteB.resistor = double.parse(t);
                          },
                          style: new TextStyle(
                              fontSize: 25.0,
                              height: 1.0,
                              color: Colors.black)),
                  //Potencias
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      widget.escolha() == Nivel.ALTA
                          ? new Text("Resistor1: ", textScaleFactor: 1)
                          : new Text("Capacitor1: ", textScaleFactor: 1),
                      new Expanded(
                          child: new DropdownButton(
                        value: potResistor1,
                        items: Utils.getDropDownMenuItems(),
                        onChanged: (t) {
                          this.setState(() {
                            widget.escolha() == Nivel.ALTA
                                ? potResistor1 = t
                                : potCapacitor1 = t;
                          });
                        },
                      )),
                      widget.escolha() == Nivel.ALTA
                          ? new Text("Resistor2: ", textScaleFactor: 1)
                          : new Text("Capacitor2: ", textScaleFactor: 1),
                      new Expanded(
                          child: new DropdownButton(
                        value: potResistor1,
                        items: Utils.getDropDownMenuItems(),
                        onChanged: (t) {
                          this.setState(() {
                            widget.escolha() == Nivel.ALTA
                                ? potResistor2 = t
                                : potCapacitor2 = t;
                          });
                        },
                      )),
                    ],
                  ),
                  new Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        widget.escolha() == Nivel.ALTA
                            ? new Text("Capacitor: ")
                            : new Text("Resistor: "),
                        new Expanded(
                            child: new DropdownButton(
                          value: potCapacitor1,
                          items: Utils.getDropDownMenuItems(),
                          onChanged: (t) {
                            this.setState(() {
                              widget.escolha() == Nivel.ALTA
                                  ? potCapacitor1 = t
                                  : potResistor1 = t;
                            });
                          },
                        )),
                      ]),
                  //Resultado
                  new Text("Freq. De Corte", textScaleFactor: 2),
                  new Text(
                      u.isNull(frequenciaCorteR.frequencia, 0.0).toString(),
                      textScaleFactor: 2),
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
