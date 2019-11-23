import 'package:flutter/material.dart';
import 'package:prova_jose_flutter_app/database_helper.dart';

import 'get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController placa = TextEditingController();
  TextEditingController modelo = TextEditingController();
  TextEditingController marca = TextEditingController();
  TextEditingController ano = TextEditingController();
  TextEditingController cor = TextEditingController();

  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crud carros'),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            ),
          ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Placa",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: placa
                ),
            TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Modelo",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: modelo
                ),  
            TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Marca",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: marca
                ),  
            TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Ano",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: ano
                ),
            RaisedButton(
              child: Text('Inserir dados', style: TextStyle(fontSize: 20),),
              onPressed: () {_inserir();},
            ),
            RaisedButton(
              child: Text('Lista Dados', style: TextStyle(fontSize: 20),),
              onPressed: () {_consultar();},
            ),
            RaisedButton(
              child: Text('Remover Ultimo', style: TextStyle(fontSize: 20),),
              onPressed: () {_removerUltimo();},
            ),
            RaisedButton(
              child: Text('Alterar Primeiro', style: TextStyle(fontSize: 20),),
              onPressed: () {_atualizar();},
            ),
          ],
        ),
      ),
    );
  }

  void _inserir() async {
    // linha para inserir
    Map<String, dynamic> row = {
      'PLACA' : placa.text,
      'MODELO' : modelo.text,
      'MARCA' : marca.text,
      'ANO' : ano.text
    };
    final id = await dbHelper.insert(row);
    print('linha inserida id: $id');
    _resetFields();
  }

  void _consultar() async {
    _resetFields();
    Navigator.push(context, MaterialPageRoute(builder: (context) => 
                Get()));
  }

  void _removerUltimo() async {
    final carro = await dbHelper.getLast();
    var id = carro['ID'];
    print(id);
    _resetFields();
    await dbHelper.remover(id);
  }

  void _atualizar() async {
    // linha para atualizar
    Map<String, dynamic> row = {
      'PLACA' : placa.text,
      'MODELO' : modelo.text,
      'MARCA' : marca.text,
      'ANO' : ano.text
    };
    final linhasAfetadas = await dbHelper.update(row, 1);
    print('UPDATE $linhasAfetadas linha(s)');
    _resetFields();
  }

  void _resetFields() {
    placa.text = "";
    modelo.text = "";
    marca.text = "";
    ano.text = "";
  }

}
