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
  final _formKey = GlobalKey<FormState>();
  FrequenciaCorte frequenciaCorte = new FrequenciaCorte();
  FrequenciaCorte frequenciaCorteA = new FrequenciaCorte();
  FrequenciaCorte frequenciaCorteB = new FrequenciaCorte();
  FrequenciaCorte frequenciaCorteR = new FrequenciaCorte();
  CapacitorService cs = new CapacitorService();
  Utils u = new Utils();
  num potFrequencia = 0.0;
  num potResistor1 = 0.0;
  num potResistor2 = 0.0;
  num potCapacitor1 = 0.0;
  num potCapacitor2 = 0.0;

  calcula() {
    FrequenciaCorte f = new FrequenciaCorte();
    if (widget.escolha() == Nivel.ALTA) {
      frequenciaCorte = frequenciaCorteA;
    } else {
      frequenciaCorte = frequenciaCorteB;
    }
    f.resistor =
        math.pow(10, potResistor1) * u.isNull(frequenciaCorte.resistor, 0.0);
    f.resistor2 =
        math.pow(10, potResistor2) * u.isNull(frequenciaCorte.resistor2, 0.0);
    f.capacitor =
        math.pow(10, potCapacitor1) * u.isNull(frequenciaCorte.capacitor, 0.0);
    f.capacitor2 =
        math.pow(10, potCapacitor2) * u.isNull(frequenciaCorte.capacitor2, 0.0);
    f.frequencia =
        math.pow(10, potFrequencia) * u.isNull(frequenciaCorte.frequencia, 0.0);
    frequenciaCorteR = cs.calcular(f, widget.escolha());
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
                        ? new TextFormField(
                            onSaved: (v) {
                              frequenciaCorteA.resistor = double.parse(v);
                            },
                            decoration: const InputDecoration(
                              labelText: 'Resistor1(R1)',
                            ))
                        : new TextFormField(
                            onSaved: (v) {
                              frequenciaCorteB.capacitor = double.parse(v);
                            },
                            decoration: const InputDecoration(
                              labelText: 'Capacitor1(C1)',
                            )),
                    widget.escolha() == Nivel.ALTA
                        ? new TextFormField(
                            onSaved: (v) {
                              frequenciaCorteA.resistor2 = double.parse(v);
                            },
                            decoration: const InputDecoration(
                              labelText: 'Resistor2(R2)',
                            ))
                        : new TextFormField(
                            onSaved: (v) {
                              frequenciaCorteB.capacitor2 = double.parse(v);
                            },
                            decoration: const InputDecoration(
                              labelText: 'Capacitor2(C2)',
                            )),
                    widget.escolha() == Nivel.ALTA
                        ? new TextFormField(
                            onSaved: (v) {
                              frequenciaCorteA.frequencia = double.parse(v);
                            },
                            decoration: const InputDecoration(
                              labelText: 'Frequencia de Corte',
                            ))
                        : new TextFormField(
                            onSaved: (v) {
                              frequenciaCorteB.frequencia = double.parse(v);
                            },
                            decoration: const InputDecoration(
                              labelText: 'Frequencia de Corte',
                            )),
                    //Potencias
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        widget.escolha() == Nivel.ALTA
                            ? new Text("Resistor1: ")
                            : new Text("Capacitor1: "),
                        new Expanded(
                            child: new DropdownButton(
                          value: widget.escolha() == Nivel.ALTA
                              ? potResistor1
                              : potCapacitor1,
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
                            ? new Text("Resistor2: ")
                            : new Text("Capacitor2: "),
                        new Expanded(
                            child: new DropdownButton(
                          value: widget.escolha() == Nivel.ALTA
                              ? potResistor2
                              : potCapacitor2,
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
                    widget.escolha() == Nivel.ALTA
                        ? new Text("Capacitor:", textScaleFactor: 2)
                        : new Text("Resistor:", textScaleFactor: 2),
                    new Text(
                        widget.escolha() == Nivel.ALTA
                            ? u
                                .isNull(frequenciaCorteR.capacitor, 0.0)
                                .toString()
                            : u
                                .isNull(frequenciaCorteR.resistor, 0.0)
                                .toString(),
                        textScaleFactor: 2)
                  ],
                ))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            this._formKey.currentState.save();
            this.calcula();
            // this._formKey.currentState.reset();
          });
        },
        tooltip: 'CALCULAR',
        child: new Icon(Icons.border_color),
      ),
    );
  }
}
