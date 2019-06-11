import 'package:calculo/model/frequencia-corte.dart';
import 'package:calculo/pages/capacitor-page.dart';
import 'package:calculo/pages/frequencia-corte-page.dart';
import 'package:calculo/pages/resistor-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text: "FC"),
                  Tab(text: "Capacitor"),
                  Tab(text: "Resistor"),
                ],
              ),
              title: Text('Calculo'),
            ),
            body: MyHomePage()),
      ),
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
    return TabBarView(
      children: [
        new FrequenciaCortePage(),
        new CapacitorPage(),
        new ResistorPage()
      ],
    );
  }
}
