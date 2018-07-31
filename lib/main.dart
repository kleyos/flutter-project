import 'package:add_just/ui/login/sing-in.dart';
import 'package:flutter/material.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/services/prefs.dart';

void main() => runApp(new AddJustApp());

class _AddJustAppState extends State<AddJustApp> {
  PrefsService prefs = new PrefsService();
  User _user;

  void _handleLogin(String username, String pwd) async {
    // do log in
    setState(() {
      _user = new User();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '+AddJust',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: new SignIn(onLogin: _handleLogin),
    );
  }
}

// This widget is the root of your application.
class AddJustApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AddJustAppState();
}
