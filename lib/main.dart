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
  List<DropdownMenuItem<num>> items = new List();
  List<num> potencias = new List.from([0, 3, 6, 9, 12, -3, -6, -9, -12]);
  num potResistor = 0;
  num potCapacitor = 0;

  List<DropdownMenuItem<num>> getDropDownMenuItems() {
    items = new List();
    potencias.forEach((valor) => {
          items.add(new DropdownMenuItem(
              value: valor, child: new Text(valor.toString())))
        });

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
    print("valor do resistor: " + f.resistor.toString());
    print("valor do capacitor: " + f.capacitor.toString());
    frequenciaCorte.resultado = fcs.calcular(f).resultado;
    f =  new FrequenciaCorte();
  }

  @override
  void initState() {
    items = getDropDownMenuItems();
    super.initState();
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
                  new Text("Resistor(R): ", textScaleFactor: 1),
                  new TextField(
                      onChanged: (t) {
                        frequenciaCorte.resistor =
                            t.isEmpty ? 0 : double.parse(t);
                      },
                      style: new TextStyle(
                          fontSize: 25.0, height: 1.0, color: Colors.black)),
                  new Text("Capacitor(C): ", textScaleFactor: 1),
                  new TextField(
                      onChanged: (t) {
                        frequenciaCorte.capacitor =
                            t.isEmpty ? 0 : double.parse(t);
                      },
                      style: new TextStyle(
                          fontSize: 25.0, height: 1.0, color: Colors.black)),
                  new Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text("Capacitor:"),
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
                          new Text("Resistor"),
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
                      )),
                  new Text("Freq. De Corte", textScaleFactor: 2),
                  new Text(
                      frequenciaCorte.resultado == null
                          ? '0'
                          : frequenciaCorte.resultado.toString(),
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
