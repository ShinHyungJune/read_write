import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:read_write/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:read_write/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import './models/user.dart';

List users = [];

void main() async {
  var db = new DatabaseHelper();

  int created = await db.create(new User("김상훈", "shin1109"));

  print("Created: $created");

  User user = await db.show(2);

  print("Showed: $user");

  user = User.fromMap({
    "id": user.id,
    "name": "이민규",
    "password": user.password
    });

  await db.update(user);

  user = await db.show(2);

  print("updated: $user");
  // User user = await db.show(2);

  // int deleted = await db.delete(2);

  // print("Deleted User: $deleted");
  
  runApp(MaterialApp(
    title: "IO",
    home: Home(),
  ));

  users = await db.all();

}

class Home extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("데이터베이스"),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                child: Text("${User.fromMap(users[index]).name[0]}"),
              ),
              title: Text("User: ${User.fromMap(users[index]).name}"),
              subtitle: Text("Id: ${User.fromMap(users[index]).id}"),
              onTap: () => debugPrint("${User.fromMap(users[index]).password}"),
            ),
          );
        },
      ),
    );
  }
}
