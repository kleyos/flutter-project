import 'package:add_just/models/user.dart';
import 'package:add_just/ui/common.dart';
import 'package:flutter/material.dart';
import 'package:add_just/ui/login/callbacks.dart';
import 'package:add_just/ui/login/code-submit.dart';
import 'package:add_just/services/api/login.dart';
import 'package:add_just/ui/login/anon-drawer.dart';

class _CodeSignInState extends State<CodeSignIn> {
  final TextEditingController _emailController = new TextEditingController();
  String _email;
  bool _isDataSending = false;

  void _handleSignIn(BuildContext context) async {
    _email = _emailController.text;
    Login loginService = new Login(baseURL: 'https://api.staging.termpay.io/api');
    setState(() {
      _isDataSending = true;
    });
    await loginService.requestCode(_emailController.text);
    if (loginService.lastError.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CodeSubmit(
          email: _email,
          onUserLoggedIn: widget._handleUserLoggerIn)
        ),
      );
    } else {
      showAlert(context, loginService.lastError);
    }
    setState(() {
      _isDataSending = false;
    });
    _emailController.clear();
  }

  Function _submitPress() {
    if (_isDataSending) {
      return null;
    } else {
      return () {
        _handleSignIn(context);
      };
    }
  }

  Widget _buildForm(BuildContext context) {
    return new Form(
      child: new Column(
        children: <Widget>[
          new Text(
            'Welcome',
          ),
          const SizedBox(height: 24.0),
          new TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              filled: true,
              labelText: 'Email'
            ),
            controller: _emailController,
          ),
          const SizedBox(height: 30.0),
          new SizedBox(
            width: double.infinity,
            height: 50.0,
            child: new FlatButton(
              onPressed: _submitPress(),
              child: new Text("Request a code", style: TextStyle(color: Colors.white, fontSize: 16.0)),
              color: Colors.teal
            )
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('+AddJust'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      drawer: new AnonDrawer(),
      body: new Container(
        decoration: new BoxDecoration(
          color: Colors.white
        ),
        padding: const EdgeInsets.all(32.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Column(
                children: <Widget>[
                  _buildForm(context)
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max
              )
            )
          ]
        )
      )
    );
  }
}

class CodeSignIn extends StatefulWidget {
  CodeSignIn({
    Key key,
    this.onUserLoggedIn
  }) : super(key: key);

  final OnUserLoggedIn onUserLoggedIn;

  @override
  State<StatefulWidget> createState() => new _CodeSignInState();

  void _handleUserLoggerIn(User user) {
    if (onUserLoggedIn != null) {
      onUserLoggedIn(user);
    }
  }
}
