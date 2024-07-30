import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todomonth/views/tasks_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weekly Tasks App',
      debugShowCheckedModeBanner: false,
      home: TasksPage(),
    );
  }
}
