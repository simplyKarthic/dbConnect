import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Isolater extends StatefulWidget {
  const Isolater({Key key}) : super(key: key);

  @override
  State<Isolater> createState() => _IsolaterState();
}

class _IsolaterState extends State<Isolater> {
  int task1, task2, task3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("isolate"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("task1: $task1"),
            Text("task2: $task2"),
            Text("task3: $task3"),
            SizedBox(height: 30,),
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  final recievePort = ReceivePort();
                  await Isolate.spawn(computeHeavyTask, recievePort.sendPort);
                  recievePort.listen((message) {
                    setState(() {
                      task1 = message;
                    });
                  });
                  print("sum1: $task1");
                },
                child: Text('Start Task')),
            SizedBox(height: 20,),
            LinearProgressIndicator(),
            SizedBox(height: 10,),
            ElevatedButton(
                onPressed: () async {
                  final recievePort2 = ReceivePort();
                  await Isolate.spawn(computeHeavyTask2, recievePort2.sendPort);
                  recievePort2.listen((message) {
                    setState(() {
                      task2 = message;
                    });
                  });
                  //int sum = computeHeavyTask(100000000);
                  print("sum2: $task2");
                },
                child: Text('Start Task 2 ')),
            SizedBox(height: 10,),
            ElevatedButton(
                onPressed: () async {
                  int result = await compute(computeHeavyTask3, 9000);
                  setState(() {
                    task3 = result;
                  });
                  print("sum3: $task3");
                },
                child: Text('Start Task 3 ')),
          ],
        ),
      ),
    );
  }
}

computeHeavyTask(SendPort sendPort) {
  print('task started');
  int sum = 0;
  for (int i = 0; i < 10000; i++) {
    sum += i;
    print("-----$i");
  }
  print('task finished');
  sendPort.send(sum);
}

computeHeavyTask2(SendPort sendPort) {
  print('task2 started');
  int sum2 = 0;
  for (int i = 0; i < 50; i++) {
    sum2 += i;
    print("+++++$i");
  }
  print('task2 finished');
  sendPort.send(sum2);
}

int computeHeavyTask3(int value) {
  print('task3 started');
  int sum3 = 0;
  for (int i = 0; i < value; i++) {
    sum3 += i;
    print("*******$i");
  }
  print('task3 finished');
  return sum3;
}