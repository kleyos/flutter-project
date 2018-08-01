import 'package:add_just/ui/login/code-submit.dart';
import 'package:flutter/material.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/services/prefs.dart';
import 'package:add_just/services/api/login.dart';
import 'package:add_just/ui/login/code-sing-in.dart';

void main() {
  runApp(new AddJustApp());
}

class _AddJustAppState extends State<AddJustApp> {
  PrefsService prefs = new PrefsService();
  User _user;

  void _showAlert(String msg) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => new AlertDialog(
        title: new Text("Alert"),
        content: new Text(msg),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      )
    );
  }

  void _handleCodeRequest(String email) async {
    Login loginService = new Login(baseURL: 'https://api.staging.termpay.io/api');
    await loginService.requestCode(email);
    if (loginService.lastError.isEmpty) {
      setState(() {
        _user = new User(email: email);
      });
      Navigator.pushNamed(context, '/codeValidate');
    } else {
      _showAlert(loginService.lastError);
    }
  }

  void _handleCodeSubmit(String code) async {

  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '+AddJust',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/codeRequest',
      home: new MaterialApp(home: CodeSignIn(onCodeRequest: _handleCodeRequest)),
      routes: {
        '/codeRequest': (context) => new CodeSignIn(onCodeRequest: _handleCodeRequest),
        '/codeValidate': (context) => new CodeSubmit(onCodeSubmit: _handleCodeSubmit)
      },
    );
  }
}

// This widget is the root of your application.
class AddJustApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AddJustAppState();
}
