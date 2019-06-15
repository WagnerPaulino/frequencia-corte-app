import 'package:calculo/main.dart';
import 'package:calculo/model/amplificacao.dart';
import 'package:calculo/service/amplificacao-service.dart';
import 'package:calculo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class GanhoPage extends StatefulWidget {
  GanhoPage({Key key}) : super(key: key);

  @override
  _GanhoPageState createState() => _GanhoPageState();
}

class _GanhoPageState extends State<GanhoPage> {
  final _formKey = GlobalKey<FormState>();
  Amplificacao amplificacao = new Amplificacao();
  Amplificacao amplificacaoR = new Amplificacao();
  AmplificacaoService apls = new AmplificacaoService();
  Utils u = new Utils();
  num potResistor = 0.0;

  calcula() {
    Amplificacao a = new Amplificacao();
    a.resistor =
        math.pow(10, potResistor) * u.isNull(amplificacao.resistor, 0.0);
    amplificacaoR = apls.ganho(a);
    a = new Amplificacao();
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
                      new TextFormField(
                          onSaved: (v) {
                            amplificacao.resistor = double.parse(v);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Resistor',
                          )),
                      //Potencias
                      new Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
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
                          ]),
                      new Text("Ganho:", textScaleFactor: 2),
                      new Text(u.isNull(amplificacaoR.ganho, 0.0).toString(),
                          textScaleFactor: 2)
                    ]),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            this._formKey.currentState.save();
            this.calcula();
          });
        },
        tooltip: 'CALCULAR',
        child: new Icon(Icons.border_color),
      ),
    );
  }
}
