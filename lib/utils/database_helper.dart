
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/user.dart';

class DatabaseHelper {
  // internal? instance? 이게 뭐임
  // 어플이 시작될 때 최초 한번만 메모리를 할당하고 그 메모리에 인스턴스를 만들어
  // 사용하는 디자인패턴, 여러차례 호출되더라도 실제로 생성되는 객체는 하나임.
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  static Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    }
    return _db = await initDb();
  }

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "maindb.db"); // home://directory/files/maindb.db

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    
    return ourDb;
  }

  /*
    users 테이블 생성
    id | name | password
    --------------------
   */
  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, password TEXT)"
    );
  }


  // INDEX
  Future<List> all() async {
    var client = await db;
    var result = await client.rawQuery("SELECT * FROM users");

    return result.toList();
  }
  
  // CREATE - Insertion(데이터 삽입 후 삽입된 데이터의 id를 반환)
  Future<int> create(User user) async {
    var client = await db;

    int respond = await client.insert("users", user.toMap());

    return respond;
  }

  // SHOW
  Future<User> show(int id) async {
    var client = await db;

    var result = await client.rawQuery("SELECT * FROM users WHERE id = $id");

    if(result.length == 0)
      return null;

    return new User.fromMap(result.first);
  }

  // DELETE
  Future<int> delete(int id) async {
    var client = await db;

    return await client.delete("users", where: "id = ?", whereArgs: [id]);
  }

  // UPDATE
  Future<int> update(User user) async {
    var client = await db;

    return await client.update("users", user.toMap(), where: "id = ?", whereArgs: [user.id]);
  }

  Future close() async {
    var client = await db;

    return client.close();
  }
}