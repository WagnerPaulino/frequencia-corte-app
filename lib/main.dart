import 'package:calculo/model/frequencia-corte.dart';
import 'package:calculo/pages/frequencia-corte-page.dart';
import 'package:calculo/pages/resistor-page.dart';
import 'package:calculo/service/frequenciaCorte-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.frequenciaCorte}) : super(key: key);

  final FrequenciaCorte frequenciaCorte;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculo'),
        ),
        body: new Center(
            child: Column(children: <Widget>[
          FlatButton(
              child: new Text(
                "Resistor",
                textScaleFactor: 2,
              ),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new ResistorPage()))),
          FlatButton(
              child: new Text(
                "Frequencia de Corte",
                textScaleFactor: 2,
              ),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new FrequenciaCortePage()))),
        ])));
  }
}
