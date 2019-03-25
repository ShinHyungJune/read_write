import 'package:flutter/material.dart';
import 'package:read_write/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatelessWidget {
  var db = new DatabaseHelper();
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
