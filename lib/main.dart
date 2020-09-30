import 'package:flutter/material.dart';

Color corpadrao = Colors.lightBlue;

void main() {
  runApp(MaterialApp(home: new Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController alturaController = new TextEditingController();
  TextEditingController pesoController = new TextEditingController();
  String _infoText = 'Informe seus dados';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFilds() {
    alturaController.clear();
    pesoController.clear();
    setState(() {
      _infoText = 'Informe seus dados';
    });
  }

  void _calcularIMC() {
    setState(() {
      double altura = double.parse(alturaController.text) / 100;
      double peso = double.parse(pesoController.text);
      double IMC = peso / (altura * altura);

      if (IMC < 18.6) {
        _infoText = "Abaixo do Peso (${IMC.toStringAsPrecision(4)})";
      } else if (IMC >= 18.6 && IMC < 24.9) {
        _infoText = "Peso Ideal (${IMC.toStringAsPrecision(4)})";
      } else if (IMC >= 24.9 && IMC < 29.9) {
        _infoText = "Levemente Acima do Peso (${IMC.toStringAsPrecision(4)})";
      } else if (IMC >= 29.9 && IMC < 34.9) {
        _infoText = "Obesidade Grau I (${IMC.toStringAsPrecision(4)})";
      } else if (IMC >= 34.9 && IMC < 39.9) {
        _infoText = "Obesidade Grau II (${IMC.toStringAsPrecision(4)})";
      } else if (IMC >= 40) {
        _infoText = "Obesidade Grau III (${IMC.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: corpadrao,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFilds,
              color: Colors.white,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 50.0, 0.0, 10.0),
                    child:
                        Icon(Icons.directions_run, size: 120.00, color: corpadrao),
                  ),

                  TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: pesoController,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: corpadrao)),
                    style: TextStyle(color: corpadrao, fontSize: 17.0),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira o peso";
                      }
                    },
                  ), //Peso
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: alturaController,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: corpadrao)),
                    style: TextStyle(color: corpadrao, fontSize: 17.0),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira a altura";
                      }
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 50.0, 0.0, 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calcularIMC();
                          }
                        },
                        child: Text("Calcular",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0)),
                        color: corpadrao,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    style: TextStyle(
                        color: corpadrao,
                        fontSize: 13,
                        fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )));
  }
}
