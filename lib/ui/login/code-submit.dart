import 'package:flutter/material.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/projects/index.dart';
import 'package:add_just/ui/login/login-screen-presenter.dart';
import 'package:add_just/ui/common.dart';

class _CodeSubmitState extends State<CodeSubmit> implements LoginContract {
  final TextEditingController _codeController = new TextEditingController();
  bool _isDataSending = false;
  LoginScreenPresenter _presenter;

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
  void onLoginSuccess(Account user) {
    setState(() { _isDataSending = false; });
    _codeController.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ProjectsIndex(
        account: user
      ))
    );
  }

  Function _submitPress() {
    return _isDataSending ? null : () { _handleSubmit(); };
  }

  void _handleSubmit() {
    setState(() {
      _isDataSending = true;
    });
    _presenter.doLogin(widget.email, _codeController.text);
  }

  Widget _buildForm() {
    return new Form(
      child: new Column(
        children: <Widget>[
          new Text(
            'Welcome',
            style: Themes.pageHeader
          ),
          new Text(
            'Please check your email and enter your verification code.',
            style: Themes.pageHeaderHint
          ),
          const SizedBox(height: 82.0),
          new TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white
            ),
            textAlign: TextAlign.center,
            controller: _codeController,
          ),
          const SizedBox(height: 32.0),
          SingleActionButton(caption: "LET'S GET STARTED", onPressed: _submitPress())
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: AddJustTitle(),
        centerTitle: true
      ),
      body: new Stack(
        children: <Widget>[
          new BackgroundImage(),
          new Container(
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
        ]
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
