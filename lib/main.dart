import 'package:flutter/material.dart';
import 'package:timer_work/expandleblist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expandable List Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpandableListView(),
    );
  }
}
