import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_assignment/data/local/dao.dart';
import 'package:todo_assignment/data/local/db/database_helper.dart';
import 'package:todo_assignment/model/ToDoListModel.dart';

class PersonalListing extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonalListingState();
  }
}

class PersonalListingState extends State<PersonalListing>{
  DatabaseHelper databaseHelper;
  ItemDao todo=new ItemDao();
  List<ToDoListModel> todoList=[ToDoListModel("Go",0)];
  int count = 0;
  List<String> _list = ["Go to the gym", "Buy groceries", "Get the haircut", "Mow the lawn", "Pic"
      "k up dry cleaning"];

  void getTodoListData() async{
    todoList= await todo.getTodoList();
    print(todoList.length);
    print('length');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<_list.length;i++){
      todo.createItem(ToDoListModel(_list.elementAt(i), 0));
    }
    getTodoListData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (todoList == null) {
      todoList = List<ToDoListModel>();
      updateListView();
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.red,
          child: ReorderableListView(
            children: List.generate(_list.length, (index) {
              String item =_list.elementAt(index);
              return Dismissible(
                  key: Key(item),
                  onDismissed: (DismissDirection dir){
                    setState(() {
                      this._list.removeAt(index);
                    });
                  },
                  background: Container(
                    child: Icon(Icons.done),
                    color: Colors.green,
                    alignment: Alignment.centerLeft,

                  ),
                  secondaryBackground: InkWell(
                    onTap: () {
                      setState(() {
                        _delete(context, todoList.elementAt(index));
                        print(todoList.length);
                      });
                    },
                    child: Container(
                      child: Icon(Icons.delete),
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.red,Colors.yellow],begin: Alignment
                            .topCenter,
                            end: Alignment.bottomCenter)
                    ),
                    child: ListTile(key: Key("${item}"), title: Text("${item}"),),
                  )
              );
            }),
            onReorder: (int start, int current) {
              // dragging from top to bottom
              if (start < current) {
                int end = current - 1;
                String startItem = _list[start];
                int i = 0;
                int local = start;
                do {
                  _list[local] = _list[++local];
                  i++;
                } while (i < end - start);
                _list[end] = startItem;
              }
              // dragging from bottom to top
              else if (start > current) {
                String startItem = _list[start];
                for (int i = start; i > current; i--) {
                  _list[i] = _list[i - 1];
                }
                _list[current] = startItem;
              }
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  void _delete(BuildContext context, ToDoListModel todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showSnackBar(context, 'Todo Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ToDoListModel>> todoListFuture = todo.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.count = todoList.length;
        });
      });
    });
  }
}