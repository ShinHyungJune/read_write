class User {
  int _id;
  String _name;
  String _password;

  User(this._name, this._password);

  User.map(dynamic object) {
    this._id = object["id"];
    this._name = object["name"];
    this._password = object["password"];
  }

  // getter
  int get id => _id;
  String get name => _name;
  String get password => _password;

  // Key는 String, value는 dynamic
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
  
    map["name"] = _name;
    map["password"] = _password;

    if(id != null) {
      map["id"] = _id;
    }

    return map;
  }

  User.fromMap(Map<String, dynamic> map){
    this._id = map["id"];
    this._name = map["name"];
    this._password = map["password"];
  }
}