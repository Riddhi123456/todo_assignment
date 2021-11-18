import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final _dbName = "todos.db";
  static final String todoTable = 'TodoTable';
  final String colItem='Item';
  // Use this class as a singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // Instantiate the database only when it's not been initialized yet.
    _database = await initializeDatabase();
    return _database;
  }

  // Creates and opens the database.
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + _dbName;

    var todosDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return todosDatabase;
  }

  // Creates the database structure
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $todoTable(id INTEGER PRIMARY KEY AUTOINCREMENT, item TEXT, isDelete int)");
  }


}