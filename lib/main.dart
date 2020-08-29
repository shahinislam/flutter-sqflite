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
