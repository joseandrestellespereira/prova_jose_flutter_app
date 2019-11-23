import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prova_jose_flutter_app/database_helper.dart';

class Get extends StatefulWidget {

  @override
  _GetState createState() => new _GetState();
}

class _GetState extends State<Get> {
  List data;
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {  
    super.initState();
    callCars();
  }

  void callCars() async {
    var response = await dbHelper.getAll();
    setState(() {
      var dados = response;
      data = dados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('listagem'),
        ),
        body:  new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, i) {
              return new ListTile(
                title: new Text(data[i]["PLACA"]),
                subtitle: new Text(data[i]["MODELO"]),
              );
            }, 
          ),
        );
  }

}