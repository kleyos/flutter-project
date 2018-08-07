import 'package:add_just/ui/projects/new-project-start.dart';
import 'package:flutter/material.dart';
import 'package:add_just/ui/login/code-sign-in.dart';

void main() {
  runApp(new AddJustApp());
}

class AddJustApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '+AddJust',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
        backgroundColor: Colors.blueGrey,
        scaffoldBackgroundColor: Color.fromRGBO(242, 242, 242, 1.0)
      ),
      routes: {
        '/': (BuildContext context) => NewProjectStart()
      }
    );
  }
}
