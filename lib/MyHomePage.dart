import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'counter.dart';
import 'firebaseConnection.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Counter counter = Counter();

  void startMySqlConnection() async {
    print("connection started");
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'student-mysql-server.mysql.database.azure.com',
        user: 'student',
        db: 'student',
        password: 'Password@123'));
    print("connection successful");
    var data = await conn.query('SELECT * FROM test');
    print("table view query");
    data.forEach((element) { print(element['name'] + ' ' + element['roll_number'].toString() );});
    print("insert data");
    var result = await conn.query('insert into test (name, roll_number) values (?, ?)', ['snow', 105]);
    print("inserted");
  }

  void _incrementCounter() async {
    final userUid = await signInWithEmail("karthic3@gmail.com","Password@123");
    print("Registered UID: $userUid");
    await addUser(userUid ,"karthic","karthic2@gmail.com");
    print("user Added ");
    await getUsers(userUid);
    //await updateUser(userUid ,"shiva","karthic2@gmail.com");
    print("updated User data");
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