import 'package:flutter/material.dart';
//import 'package:mysql1/mysql1.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlconnector/sharedPref.dart';
import 'package:sqlconnector/sqLite.dart';
import 'package:sqlite3/sqlite3.dart';
import 'counter.dart';
import 'firebaseConnection.dart';
import 'dart:io';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Counter counter = Counter();

  // void startMySqlConnection() async {
  //   print("connection started");
  //   final conn = await MySqlConnection.connect(ConnectionSettings(
  //       host: 'student-mysql-server.mysql.database.azure.com',
  //       user: 'student',
  //       db: 'student',
  //       password: 'Password@123'));
  //   print("connection successful");
  //   var data = await conn.query('SELECT * FROM test');
  //   print("table view query");
  //   data.forEach((element) { print(element['name'] + ' ' + element['roll_number'].toString() );});
  //   print("insert data");
  //   var result = await conn.query('insert into test (name, roll_number) values (?, ?)', ['snow', 105]);
  //   print("inserted");
  // }

  void _incrementCounter() async {
    // Map<String, dynamic> name = {
    //   'firstName': 'Karthic',
    //   'lastName': 'J',
    //   'phNumber': 9445225700,
    //   'verified': true
    // };
    //await saveMapData(name);
    //await removeData('map_data');
    // Map savedName = await getMapData();
    // print("name: ${savedName}");

    // var documentsDirectory = await getApplicationDocumentsDirectory();
    // var databasePath = '${documentsDirectory.path}/my_database.db';

    final db = sqlite3.openInMemory();

    db.execute('''
    CREATE TABLE artists (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
  ''');

    final stmt = db.prepare('INSERT INTO artists (name) VALUES (?)');
    stmt
      ..execute(['The Beatles'])
      ..execute(['Led Zeppelin'])
      ..execute(['The Who'])
      ..execute(['Nirvana']);

    stmt.dispose();

    final ResultSet resultSet = db.select('SELECT * FROM artists WHERE name LIKE ?', ['The %']);


    for (final row in resultSet) {
      print('Artist[id: ${row['id']}, name: ${row['name']}]');
    }

    db.dispose();

    setState(() {
      counter.incrementcounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counter.count}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}