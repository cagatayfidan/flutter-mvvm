import 'package:flutter/material.dart';
import 'package:my_app/ui.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const appTitle = 'Todo App Demo';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: TaskWidget(),
      ),
    );
  }
}
