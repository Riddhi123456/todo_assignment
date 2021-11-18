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


  /*Future<int> insertTodo(ToDoListModel todo) async {
    Database db = await this.database;
    var result = await db.insert(todoTable, todo.toMap());
    return result;
  }
*/
  /*Future<int> updateTodo(ToDoListModel todo) async {
    var db = await this.database;
    var result = await db.update(todoTable, todo.toMap(), where: '$colItem = ?', whereArgs: [todo
        .item]);
    return result;
  }*/


  Future<int> deleteTodo(int item) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $todoTable WHERE $colItem = $item');
    return result;
  }

  /*Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $todoTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }*/



}