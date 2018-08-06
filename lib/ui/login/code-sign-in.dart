import 'package:add_just/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/login/login-screen-presenter.dart';
import 'package:add_just/ui/login/code-submit.dart';
import 'package:add_just/ui/login/anon-drawer.dart';

class _CodeSignInState extends State<CodeSignIn> implements LoginContract {
  final TextEditingController _emailController = new TextEditingController();
  bool _isDataSending = false;
  LoginScreenPresenter _presenter;

  _CodeSignInState() {
    _presenter = new LoginScreenPresenter(this);
  }

  void _handleSubmit() {
    setState(() {
      _isDataSending = true;
    });
    _presenter.requestCode(_emailController.text);
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
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => CodeSubmit(
        email: email
      ))
    );
  }

  Function _submitPress() {
    return _isDataSending ? null : () { _handleSubmit(); };
  }

  Widget _buildForm() {
    return new Form(
      child: new Column(
        children: <Widget>[
          new Text('Welcome',
            style: Themes.pageHeader,
          ),
          new Text('Please specify your email to get your verification code.',
            style: Themes.pageHeaderHint
          ),
          const SizedBox(height: 24.0),
          new TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              filled: true,
              labelText: 'Email',
              fillColor: Colors.white
            ),
            controller: _emailController,
          ),
          const SizedBox(height: 30.0),
          new SizedBox(
            width: double.infinity,
            height: 50.0,
            child: new RaisedButton(
              onPressed: _submitPress(),
              child: new Text('REQUEST A CODE',
                style: Themes.buttonCaption),
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
        centerTitle: true
      ),
      body: new Container(
        padding: const EdgeInsets.only(left: 52.0, right: 52.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Column(
                children: <Widget>[
                  _buildForm()
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
