class ToDoListModel{
  int _id=0;
  int get id => _id;
  set id(int value) {
    _id = value;
  }

  String _item;
  int _isDeleted;


  ToDoListModel(this._id,this._item, this._isDeleted);

  String get item => _item;

  set item(String value) {
    _item = value;
  }

  int get isDeleted => _isDeleted;

  set isDeleted(int value) {
    _isDeleted = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id']=_id;
    map['item'] = _item ;
    map['isDelete'] = _isDeleted;
    return map;
  }

  ToDoListModel.fromMapObject(Map<String, dynamic> map) {
    _id=map['id'];
    _item = map['item'];
    _isDeleted = map['isDelete'];

  }
}
