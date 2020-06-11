import 'dart:async';
import 'dart:io' as io;

import 'package:assesmentexample/login/db/userModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static String TABLE_USER = "users";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  DatabaseHelper.internal();

  _initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "users.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(""" 
    CREATE TABLE $TABLE_USER(
      user_id INTEGER PRIMARY KEY,
      name TEXT,
      age INTEGER,
      phone TEXT
    )""");
    print("Created user tables");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await instance.database;
    int res = await dbClient.insert(TABLE_USER, user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);
    print("id $res");
    return res;
  }

  Future<User> loginUser(String name, String phone) async {
    var dbClient = await instance.database;
    List<Map> result = await dbClient.query(TABLE_USER,
        columns: ["user_id","name", "age", "phone"],
        where: 'name = ? AND phone = ?',
        whereArgs: [name,phone]);


    if (result.length > 0) {
      print(result.first);
      return new User.fromMap(result.first);
    }

    return null;
  }

  Future<User> getUser(int id) async {
    var dbClient = await instance.database;
    String sql =
        "SELECT * FROM $TABLE_USER WHERE user_id = $id";
    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    return User.fromMap(result.first);
  }
}