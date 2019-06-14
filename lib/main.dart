import 'package:calculo/enums/niveis.dart';
import 'package:calculo/model/frequencia-corte.dart';
import 'package:calculo/pages/capacitor-page.dart';
import 'package:calculo/pages/frequencia-corte-page.dart';
import 'package:calculo/pages/resistor-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
var nivel = Nivel.ALTA;
var callbacks = [];

getEscolha() {
  return nivel;
}

setCallback(value) {
  callbacks.add(value);
}

callCallbacks() {
  callbacks.forEach((r) => r(() {}));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.frequenciaCorte}) : super(key: key);

  final FrequenciaCorte frequenciaCorte;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: "FC"),
    Tab(text: "Capacitor"),
    Tab(text: "Resistor")
  ];

  @override
  void initState() {
    _tabController =
        new TabController(vsync: this, initialIndex: 0, length: myTabs.length);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    callbacks = [];
    super.dispose();
  }

  _handleTabSelection() {
    this.setState(() => callCallbacks());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  tabs: myTabs,
                  controller: _tabController,
                ),
                title: Text('Calculo'),
              ),
              drawer: getDrawerEscolha(),
              body: TabBarView(
                children: [
                  new FrequenciaCortePage(escolha: getEscolha),
                  new CapacitorPage(escolha: getEscolha),
                  new ResistorPage(escolha: getEscolha)
                ],
                controller: _tabController,
              )),
        ),
        debugShowCheckedModeBanner: false);
  }

  Widget getDrawerEscolha() {
    return new Drawer(
        child: new ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return new ListBody(
          children: <Widget>[
            new DrawerHeader(
              child: new Text("Categoria"),
            ),
            new ListTile(
              title: new Text('Alta'),
              onTap: () {
                nivel = Nivel.ALTA;
                Navigator.pop(context);
                this.setState(() => callCallbacks());
              },
            ),
            new ListTile(
              title: new Text('Baixa'),
              onTap: () {
                nivel = Nivel.BAIXA;
                Navigator.pop(context);
                this.setState(() => callCallbacks());
              },
            ),
          ],
        );
      },
    ));
  }
}
