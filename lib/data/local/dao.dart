import 'package:sqflite/sqflite.dart';
import 'package:todo_assignment/data/local/db/database_helper.dart';
import 'package:todo_assignment/model/ToDoListModel.dart';

class ItemDao{
  DatabaseHelper dh=DatabaseHelper.instance;

  Future<int> createItem(ToDoListModel itemModel) async {
    Map m=itemModel.toMap();
    print(m);
    Database database = await dh.database;
    return database.insert(
      DatabaseHelper.todoTable,
      itemModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> checkUser(String item) async {
    Database database = await dh.database;
    bool isValid = false;
    List<Map<String, dynamic>> map =
    await database.query(DatabaseHelper.todoTable, where: "item = ?", whereArgs: [item]);
    List<ToDoListModel> todoList = new List();

    print(map);
    for(Map m in map){
      todoList.add(ToDoListModel.fromMapObject(m));
    }

    return isValid;
  }

  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database database = await dh.database;
    var result = await database.query(DatabaseHelper.todoTable);
    return result;
  }


  Future<List<ToDoListModel>> getTodoList() async {

    var todoMapList = await getTodoMapList();
    int count = todoMapList.length;

    List<ToDoListModel> todoList = List<ToDoListModel>();
    for (int i = 0; i < count; i++) {
      todoList.add(ToDoListModel.fromMapObject(todoMapList[i]));
    }

    return todoList;
  }

}