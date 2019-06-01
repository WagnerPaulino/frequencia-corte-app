import 'package:calculo/model/frequencia-corte.dart';
import 'package:calculo/service/frequenciaCorte-service.dart';
import 'package:flutter/material.dart';

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
                  frequenciaCorte.resistor = t == null ? 0 : double.parse(t);
                },
                style: new TextStyle(
                    fontSize: 25.0, height: 1.0, color: Colors.black),
                keyboardType: TextInputType.number),
            new Text("Capacitor(C): ", textScaleFactor: 1),
            new TextField(
                onChanged: (t) {
                  frequenciaCorte.capacitor = t == null ? 0 : double.parse(t);
                },
                style: new TextStyle(
                    fontSize: 25.0, height: 1.0, color: Colors.black),
                keyboardType: TextInputType.number),
            new Text("Freq. De Corte", textScaleFactor: 2),
            new Text(
                frequenciaCorte.resultado == null
                    ? '0'
                    : frequenciaCorte.resultado.toString(),
                textScaleFactor: 2)
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            frequenciaCorte = fcs.calcular(frequenciaCorte);
          });
        },
        tooltip: 'CALCULAR',
        child: new Icon(Icons.border_color),
      ),
    );
  }
}
