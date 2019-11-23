import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = "CarrosDB.db";
  static final _dbVersion = 1;

  //Transforma a classe em Singleton para Gerenciar
  //as conexões do Banco
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  //SINGLETON
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;//Retorna a Database instanciada
  }

  initDatabase() async {
    Directory dbDiretory = await getApplicationDocumentsDirectory();
    String path = join(dbDiretory.path, _dbName); //Monta o caminho da database
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  
  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE CARRO 
                        (ID INTEGER PRIMARY KEY, 
                         PLACA TEXT,
                         MODELO TEXT,
                         MARCA TEXT,
                         ANO INTEGER)''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert("CARRO", row);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    Database db = await instance.database;
    return await db.query("CARRO");
  }

  Future<Map<String, dynamic>> getLast() async {
    Database db = await instance.database;
    var pessoas = await db.query("CARRO", limit: 1, orderBy: "ID DESC");
    return pessoas.first;
  }

  Future<int> remover(int id) async {
    Database db = await instance.database;
    return await db.delete("CARRO", where: "ID = ?", whereArgs: [id]);
  }

  Future<int> update(Map<String, dynamic> row, int id) async {
    Database db = await instance.database;
    return await db.update("CARRO", row, where: 'ID = ?', whereArgs: [id]);
  }

}
