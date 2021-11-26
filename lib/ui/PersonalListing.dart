import 'package:flutter/material.dart';
import 'package:todo_assignment/data/local/dao.dart';
import 'package:todo_assignment/model/ToDoListModel.dart';

class PersonalListing extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonalListingState();
  }
}

class PersonalListingState extends State<PersonalListing>{
  var scaffoldKey = new GlobalKey<ScaffoldState>();
  ItemDao todo=new ItemDao();
  List<ToDoListModel> todoList=List.empty(growable: true);
  TextEditingController _controller=new TextEditingController();
  FocusNode _focus=new FocusNode();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setExistingData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          color: Colors.red,
          child: Column(
            children: [
              Expanded(
                child: todoList!=null && todoList.isNotEmpty?   ReorderableListView(
                  children: List.generate(todoList.length, (index) {
                    String item = todoList.elementAt(index).item;
                    return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (DismissDirection dir) {

                          if(dir==DismissDirection.endToStart){
                            todo.deleteItem(index+1).then((value) => showSnackBar("Deleted successfully"));
                            fetchData();
                            showSnackBar('Item removed');
                          }
                          if(dir==DismissDirection.startToEnd){
                            todo.deleteItem(index+1).then((value) => showSnackBar("Deleted successfully"));
                            fetchData();
                            showSnackBar('Item Completed');
                          }
                        },
                        background: Container(
                          child: Icon(Icons.done),
                          color: Colors.green,
                          alignment: Alignment.centerLeft,
                        ),
                        secondaryBackground: Container(
                          child: Icon(Icons.delete),
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.red, Colors.yellow],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: ListTile(
                            key: Key("${item}"),
                            title: Text("${item}"),
                          ),
                        ));
                  }),
                  onReorder: (int start, int current) {
                    // dragging from top to bottom
                    if (start < current) {
                      int end = current - 1;
                      ToDoListModel startItem = todoList[start];
                      int i = 0;
                      int local = start;
                      do {
                        todoList[local] = todoList[++local];
                        i++;
                      } while (i < end - start);
                      todoList[end] = startItem;
                    }
                    // dragging from bottom to top
                    else if (start > current) {
                      ToDoListModel startItem = todoList[start];
                      for (int i = start; i > current; i--) {
                        todoList[i] = todoList[i - 1];
                      }
                      todoList[current] = startItem;
                    }
                    setState(() {});
                  },
                ):Container(),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: TextField(
                          controller:_controller ,
                          focusNode: _focus,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            hintText: 'Enter the Text',
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.black,
                      padding: EdgeInsets.only(top: 20,bottom: 20),
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        bool isExist = await todo.checkItem(_controller.text);
                        if(!isExist) {
                          int count = await todo.getCount();
                          todo
                              .createItem(
                              ToDoListModel(count + 1, _controller.text, 0))
                              .then((value) => {showSnackBar("Data Inserted....")});
                          fetchData();

                          _controller.text='';
                        }else{
                          showSnackBar("Already Exist");
                        }

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  void fetchData() async {
    todoList.clear();
    var ll = await todo.getTodoList();
    todoList.addAll(ll);
    setState(() {});
  }

  void setExistingData()async {
    int count = await todo.getCount();
    if(count>=1){
      fetchData();
    }
  }

  showSnackBar(String str, {Color bgColor = Colors.red}) {
    var snackbar = new SnackBar(
      content: new Text(str),
      duration: Duration(seconds: 2),
      backgroundColor: bgColor,
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
