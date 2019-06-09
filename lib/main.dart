import 'package:calculo/model/frequencia-corte.dart';
import 'package:calculo/service/frequenciaCorte-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frequencia de Corte',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.frequenciaCorte}) : super(key: key);

  final String title = 'Frequencia de Corte';
  final FrequenciaCorte frequenciaCorte;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FrequenciaCorteService fcs = new FrequenciaCorteService();
  FrequenciaCorte frequenciaCorte = new FrequenciaCorte();
  List<DropdownMenuItem<int>> items = new List();
  Map<int, String> potenciaMap = {
    0: "Und",
    12: "Tera",
    9: "Giga",
    6: "Mega",
    3: "Quilo",
    -3: "Mili",
    -6: "Micro",
    -9: "Nano",
    -12: "Pico"
  };

  num potResistor = 0;
  num potCapacitor = 0;
  num potResistor2 = 0;
  num potCapacitor2 = 0;
  bool enabled = false;

  List<DropdownMenuItem<int>> getDropDownMenuItems() {
    items = new List();
    potenciaMap.forEach((value, label) => {
          items.add(new DropdownMenuItem(value: value, child: new Text(label)))
        });
    // for(var entry in potenciaMap.entries) {
    //   items.add(new DropdownMenuItem(
    //           value: entry.key, child: new Text(entry.value)));
    // }
    return items;
  }

  calcula() {
    FrequenciaCorte f = new FrequenciaCorte();
    if (potCapacitor == null || potResistor == null) {
      potCapacitor = 0;
      potResistor = 0;
    }
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
    items = getDropDownMenuItems();
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
        title: Text(widget.title),
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
                        items: getDropDownMenuItems(),
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
                        items: getDropDownMenuItems(),
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
                            items: getDropDownMenuItems(),
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
                            items: getDropDownMenuItems(),
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
