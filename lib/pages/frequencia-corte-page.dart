import 'package:calculo/model/frequencia-corte.dart';
import 'package:calculo/service/frequenciaCorte-service.dart';
import 'package:calculo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class FrequenciaCortePage extends StatefulWidget {
  FrequenciaCortePage({Key key}) : super(key: key);

  @override
  _FrequenciaCortePageState createState() => _FrequenciaCortePageState();
}

class _FrequenciaCortePageState extends State<FrequenciaCortePage> {
  FrequenciaCorteService fcs = new FrequenciaCorteService();
  FrequenciaCorte frequenciaCorte = new FrequenciaCorte();

  num potResistor = 0;
  num potCapacitor = 0;
  num potResistor2 = 0;
  num potCapacitor2 = 0;
  bool enabled = false;

  calcula() {
    FrequenciaCorte f = new FrequenciaCorte();
    f.capacitor = math.pow(10, potCapacitor) * frequenciaCorte.capacitor;
    f.resistor = math.pow(10, potResistor) * frequenciaCorte.resistor;
    if (frequenciaCorte.capacitor2 != null &&
        frequenciaCorte.resistor2 != null) {
      f.capacitor2 = math.pow(10, potCapacitor2) * frequenciaCorte.capacitor2;
      f.resistor2 = math.pow(10, potResistor2) * frequenciaCorte.resistor2;
    }
    frequenciaCorte.frequencia = fcs.calcular(f).frequencia;
    f = new FrequenciaCorte();
  }

  @override
  void initState() {
    super.initState();
  }

  isEnable() {
    if (frequenciaCorte.capacitor != 0 && frequenciaCorte.resistor != 0) {
      this.setState(() => this.enabled = true);
    } else {
      this.setState(() => this.enabled = false);
    }
    if (frequenciaCorte.capacitor == null || frequenciaCorte.resistor == null) {
      this.setState(() => this.enabled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frequencia de Corte'),
      ),
      body: new SingleChildScrollView(
          child: new Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("Resistor1(R1): ", textScaleFactor: 1),
                  new TextField(
                      onChanged: (t) {
                        frequenciaCorte.resistor =
                            t.isEmpty ? null : double.parse(t);
                        this.isEnable();
                      },
                      style: new TextStyle(
                          fontSize: 25.0, height: 1.0, color: Colors.black)),
                  new Text("Capacitor1(C1): ", textScaleFactor: 1),
                  new TextField(
                      onChanged: (t) {
                        frequenciaCorte.capacitor =
                            t.isEmpty ? null : double.parse(t);
                        this.isEnable();
                      },
                      style: new TextStyle(
                          fontSize: 25.0, height: 1.0, color: Colors.black)),
                  new Text("Resistor2(R2): ", textScaleFactor: 1),
                  new TextField(
                    onChanged: (t) {
                      frequenciaCorte.resistor2 =
                          t.isEmpty ? null : double.parse(t);
                    },
                    style: new TextStyle(
                        fontSize: 25.0, height: 1.0, color: Colors.black),
                    enabled: this.enabled,
                  ),
                  new Text("Capacitor2(C2): ", textScaleFactor: 1),
                  new TextField(
                      onChanged: (t) {
                        frequenciaCorte.capacitor2 =
                            t.isEmpty ? null : double.parse(t);
                      },
                      style: new TextStyle(
                          fontSize: 25.0, height: 1.0, color: Colors.black),
                      enabled: this.enabled),
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                      new Text("Resistor: "),
                      new Expanded(
                          child: new DropdownButton(
                        value: potResistor,
                        items: Utils.getDropDownMenuItems(),
                        onChanged: (t) {
                          this.setState(() {
                            potResistor = t;
                          });
                        },
                      ))
                    ],
                  ),
                  new Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text("Capacitor2: "),
                          new Expanded(
                              child: new DropdownButton(
                            value: potCapacitor2,
                            items: Utils.getDropDownMenuItems(),
                            onChanged: (t) {
                              this.setState(() {
                                potCapacitor2 = t;
                              });
                            },
                          )),
                          new Text("Resistor2: "),
                          new Expanded(
                              child: new DropdownButton(
                            value: potResistor2,
                            items: Utils.getDropDownMenuItems(),
                            onChanged: (t) {
                              this.setState(() {
                                potResistor2 = t;
                              });
                            },
                          ))
                        ],
                      )),
                  new Text("Freq. De Corte", textScaleFactor: 2),
                  new Text(
                      frequenciaCorte.frequencia == null
                          ? '0'
                          : frequenciaCorte.frequencia.toString(),
                      textScaleFactor: 2),
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (this.frequenciaCorte.capacitor != null &&
              this.frequenciaCorte.resistor != null) {
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
