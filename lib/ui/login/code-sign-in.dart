import 'package:flutter/material.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/login/login-screen-presenter.dart';
import 'package:add_just/ui/login/code-submit.dart';
import 'package:add_just/ui/login/anon-drawer.dart';

class _CodeSignInState extends State<CodeSignIn> implements LoginContract {
  final TextEditingController _emailController = new TextEditingController();
  String _email;
  bool _isDataSending = false;
  LoginScreenPresenter _presenter;
  BuildContext _ctx;

  _CodeSignInState() {
    _presenter = new LoginScreenPresenter(this);
  }

  void _handleSubmit() {
    _email = _emailController.text;
    setState(() {
      _isDataSending = true;
    });
    _presenter.requestCode(_email);
    _emailController.clear();
  }

  @override
  void onLoginError(String errorTxt) {
    showAlert(context, errorTxt);
    setState(() {
      _isDataSending = false;
    });
  }

  @override
  void onLoginSuccess(User user) {
  }

  @override
  void onLoginCodeRequested(String email) {
    setState(() { _isDataSending = false; });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CodeSubmit(
        email: email
      ))
    );
  }

  Function _submitPress() {
    if (_isDataSending) {
      return null;
    } else {
      return () {
        _handleSubmit();
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
            child: new RaisedButton(
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
    _ctx = context;
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
  @override
  State<StatefulWidget> createState() => new _CodeSignInState();
}
