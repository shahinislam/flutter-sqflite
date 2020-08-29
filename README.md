# flutter_sqflite

A new Flutter project.

![flutter-sqflite](https://user-images.githubusercontent.com/33843231/91641657-b183bd80-ea47-11ea-9eb3-00d3aebe5f56.png)

## database_helper.dart
```dart

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'myTable';
  static final columnId = '_id';
  static final columnName = 'name';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $_tableName(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL )
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}



```

## main.dart

```dart

import 'package:flutter/material.dart';
import 'package:flutter_sqflite/database_helper.dart';

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqflite Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                onPressed: () async {
                  int result = await DatabaseHelper.instance
                      .insert({DatabaseHelper.columnName: 'Shahinur'});
                  print('The inserted id is $result');
                },
                child: Text('insert'),
                color: Colors.grey[400]),
            FlatButton(
                onPressed: () async {
                  List<Map<String, dynamic>> queryRows =
                      await DatabaseHelper.instance.queryAll();
                  print(queryRows);
                },
                child: Text('query'),
                color: Colors.green),
            FlatButton(
                onPressed: () async {
                  int updateId = await DatabaseHelper.instance.update({
                    DatabaseHelper.columnId: 1,
                    DatabaseHelper.columnName: 'Aminur'
                  }); 
                  print(updateId);
                },
                child: Text('update'),
                color: Colors.blue[100]),
            FlatButton(
                onPressed: () async {
                  int rowsEffected = await DatabaseHelper.instance.delete(1);
                  print(rowsEffected);
                },
                child: Text('delete'),
                color: Colors.red[300]),
          ],
        ),
      ),
    );
  }
}


```
