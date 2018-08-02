import 'package:flutter/material.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/services/prefs.dart';
import 'package:add_just/ui/login/code-sign-in.dart';

void main() {
  runApp(new AddJustApp());
}

class _AddJustAppState extends State<AddJustApp> {
  PrefsService prefs = new PrefsService();
  User _user;

  void _handleUserLoggedIn(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '+AddJust',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: CodeSignIn(onUserLoggedIn: _handleUserLoggedIn)
    );
  }
}

// This widget is the root of your application.
class AddJustApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AddJustAppState();
}
