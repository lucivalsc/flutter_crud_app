import 'dart:async';
import 'dart:io';
import 'package:flutter_crud_app/model/people_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

const String databaseName = 'bd3';
const int databaseVersion = 1;

class Databasepadrao {
  Databasepadrao._privateConstructor();
  static final Databasepadrao instance = Databasepadrao._privateConstructor();
  static Database? _database;

  Future<Database?> get db async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(PeopleModel.sqlPeople);
  }

  Future<int> insertData(String tabela, modelData) async {
    Database? dbPadrao = await db;
    return await dbPadrao!.insert(tabela, modelData.toJson());
  }

  Future<int> updateData(String tabela, coluna, id, modelData) async {
    Database? dbPadrao = await db;
    return await dbPadrao!.update(
      tabela,
      modelData.toJson(),
      where: "$coluna = ?",
      whereArgs: [id],
    );
  }

  Future<List<Map>> selectData(String tabela) async {
    Database? dbPadrao = await db;
    return await dbPadrao!.query(tabela);
  }

  Future deleteData(String tabela, String coluna, int id) async {
    Database? dbPadrao = await db;
    await dbPadrao!.delete(
      tabela,
      where: "$coluna = ?",
      whereArgs: [id],
    );
  }

  Future close() async {
    Database? dbPadrao = await db;
    dbPadrao!.close();
  }
}
