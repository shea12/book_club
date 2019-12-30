class ItemModel{
  int _userId;
  int _id;
  String _title;
  String _body;
  ItemModel.fromJson(Map<String,dynamic> parsedJson){
    _userId = parsedJson['userId'];
    _id = parsedJson['id'];
    _title = parsedJson['title'];
    _body = parsedJson['body'];
  }

  String get body => _body;

  String get title => _title;

  int get id => _id;

  int get userId => _userId;

}