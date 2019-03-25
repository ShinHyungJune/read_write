import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:read_write/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:read_write/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import './models/user.dart';

List users;

void main() async {
  var db = new DatabaseHelper();

  int user = await db.create(new User("123123", "shin1109"));

  runApp(MaterialApp(
    title: "IO",
    home: Home(),
  ));

  users = await db.index();

  for(int i=0; i<users.length; i++){
    User user = User.map(users[i]);

    print(user.name);
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("데이터베이스"),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
