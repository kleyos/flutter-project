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
        primarySwatch: Colors.grey,
      ),
      routes: {
        '/': (BuildContext context) => CodeSignIn()
      }
    );
  }
}
