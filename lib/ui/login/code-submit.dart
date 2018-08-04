import 'package:flutter/material.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/ui/projects/index.dart';
import 'package:add_just/ui/login/login-screen-presenter.dart';
import 'package:add_just/ui/common.dart';

class _CodeSubmitState extends State<CodeSubmit> implements LoginContract {
  final TextEditingController _codeController = new TextEditingController();
  bool _isDataSending = false;
  LoginScreenPresenter _presenter;
  BuildContext _ctx;

  _CodeSubmitState() {
    _presenter = new LoginScreenPresenter(this);
  }

  @override
  void onLoginCodeRequested(String email) {
  }

  @override
  void onLoginError(String errorTxt) {
    showAlert(context, errorTxt);
    setState(() { _isDataSending = false; });
  }

  @override
  void onLoginSuccess(User user) {
    setState(() { _isDataSending = false; });
    Navigator.pushReplacement(
      _ctx,
      MaterialPageRoute(builder: (context) => ProjectsIndex(
        user: user
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

  void _handleSubmit() {
    setState(() {
      _isDataSending = true;
    });
    _presenter.doLogin(widget.email, _codeController.text);
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
              onPressed: _submitPress(),
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
    _ctx = context;
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

class CodeSubmit extends StatefulWidget {
  CodeSubmit({
    Key key,
    this.email
  }) : super(key: key);

  final String email;
  @override
  State<CodeSubmit> createState() => new _CodeSubmitState();
}
