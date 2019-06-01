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
  final _formKey = GlobalKey<FormState>();
  TextEditingController resistorController = new TextEditingController();
  TextEditingController capacitorController = new TextEditingController();
  List<int> potencias = new List();

  List<DropdownMenuItem<int>> getDropDownMenuItems() {
    List<DropdownMenuItem<int>> items = new List();
    for (int city in potencias) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: city, child: new Text("")));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Form(
              key: _formKey,
              child: new Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("Resistor(R): ", textScaleFactor: 1),
                      TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Deve ter um número aqui!';
                            }
                          },
                          controller: resistorController,
                          onSaved: (t) => frequenciaCorte.resistor =
                              t == null ? 0 : double.parse(t),
                          style: new TextStyle(
                              fontSize: 25.0,
                              height: 1.0,
                              color: Colors.black)),
                      new Text("Capacitor(R): ", textScaleFactor: 1),
                      TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Deve ter um número aqui!';
                            }
                          },
                          controller: capacitorController,
                          onSaved: (t) => frequenciaCorte.capacitor =
                              t == null ? 0 : double.parse(t),
                          style: new TextStyle(
                              fontSize: 25.0,
                              height: 1.0,
                              color: Colors.black)),
                      new Text("Freq. De Corte", textScaleFactor: 2),
                      new Text(
                          frequenciaCorte.resultado == null
                              ? '0'
                              : frequenciaCorte.resultado.toString(),
                          textScaleFactor: 2),
                    ],
                  ))),
          new Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text("Capacitor:"),
              new Expanded(
                  child: new TextField(
                      onChanged: (t) {
                        if (t.isNotEmpty) {
                          this.setState(() {
                            this.frequenciaCorte.capacitor =
                                math.pow(10, int.parse(t));
                          });
                        }
                      },
                      style:
                          new TextStyle(fontSize: 25.0, color: Colors.black))),
              new Text("Resistor"),
              new Expanded(
                child: new TextField(
                    onChanged: (t) {
                        if (t.isNotEmpty) {
                          this.setState(() {
                            this.frequenciaCorte.resistor =
                                math.pow(10, int.parse(t));
                          });
                        }
                      },
                    style: new TextStyle(fontSize: 25.0, color: Colors.black)),
              )
            ],
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            this._formKey.currentState.save();
            frequenciaCorte = fcs.calcular(frequenciaCorte);
          });
        },
        tooltip: 'CALCULAR',
        child: new Icon(Icons.border_color),
      ),
    );
  }
}
