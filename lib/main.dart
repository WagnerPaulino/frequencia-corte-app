import 'package:calculo/enums/niveis.dart';
import 'package:calculo/model/frequencia-corte.dart';
import 'package:calculo/pages/capacitor-page.dart';
import 'package:calculo/pages/frequencia-corte-page.dart';
import 'package:calculo/pages/resistor-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
var nivel = Nivel.PADRAO;

getEscolha() {
  return nivel;
}

class MyApp extends StatelessWidget {
  Widget getDrawerEscolha() {
    return new Drawer(
        child: new ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return new ListBody(
          children: <Widget>[
            new DrawerHeader(
            child: new Text("Níveis"),
          ),
          new ListTile(
            title: new Text('Padrão'),
            onTap: () {
              nivel = Nivel.PADRAO;
              Navigator.pop(context);
            },
          ),
          new ListTile(
            title: new Text('Alta'),
            onTap: () {
              nivel = Nivel.ALTA;
              Navigator.pop(context);
            },
          ),
          new ListTile(
            title: new Text('Baixa'),
            onTap: () {
              nivel = Nivel.BAIXA;
              Navigator.pop(context);
            },
          ),
          ],
        );
      },
    ));
  }

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
            drawer: getDrawerEscolha(),
            body: MyHomePage()),
      ),
      debugShowCheckedModeBanner: false
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
        new FrequenciaCortePage(escolha: getEscolha),
        new CapacitorPage(escolha: getEscolha),
        new ResistorPage(escolha: getEscolha)
      ],
    );
  }
}
