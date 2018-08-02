import 'package:flutter/material.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/services/api/base.dart';
import 'package:add_just/services/api/login.dart';
import 'package:add_just/ui/login/callbacks.dart';

class CodeSubmit extends StatelessWidget {
  CodeSubmit({
    Key key,
    this.email,
    this.onUserLoggedIn
  }) : super(key: key);

  final String email;
  final OnUserLoggedIn onUserLoggedIn;
  final TextEditingController _codeController = new TextEditingController();

  void _handleSubmit(BuildContext context) async {
    Login loginService = new Login(baseURL: 'https://api.staging.termpay.io/api');
    ApiResponse resp = await loginService.requestToken(email, _codeController.text);
    if (loginService.lastError.isEmpty) {
      if (onUserLoggedIn != null) {
        onUserLoggedIn(User.fromApiResponse(resp));
      }
    } else {
      showAlert(context, loginService.lastError);
    }
    _codeController.clear();
  }

  Widget _buildForm(BuildContext context) {
    return new Form(
      child: new Column(
        children: <Widget>[
          new Text(
            'Welcome',
          ),
          new Text(
            'Please check your email and enter your verification code.'
          ),
          const SizedBox(height: 24.0),
          new TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              filled: true,
            ),
            controller: _codeController,
          ),
          const SizedBox(height: 30.0),
          new SizedBox(
            width: double.infinity,
            height: 50.0,
            child: new FlatButton(
              onPressed: () {
                _handleSubmit(context);
              },
              child: new Text("LET'S GET STARTED",
                style: TextStyle(color: Colors.white, fontSize: 16.0)),
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
