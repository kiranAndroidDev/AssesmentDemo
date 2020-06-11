class User {
  int _user_id;
  String _name;
  int _age;
  String _phone;

  User(this._name, this._age, this._phone);

  User.fromMap(dynamic obj) {
    this._user_id = obj['user_id'];
    this._name = obj['name'];
    this._age = obj['age'];
    this._phone = obj['phone'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['user_id'] = _user_id;
    map['name'] = _name;
    map['age'] = _age;
    map['phone'] = _phone;

    return map;
  }

  //getters
  int get userId => _user_id;

  String get name => _name;

  int get age => _age;

  String get phone => _phone;
}
