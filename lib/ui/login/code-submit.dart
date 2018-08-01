import 'package:flutter/material.dart';

typedef void OnCodeSubmitCallback(String code);

class CodeSubmit extends StatelessWidget {
  CodeSubmit({
    Key key,
    this.onCodeSubmit
  }) : super(key: key);

  final OnCodeSubmitCallback onCodeSubmit;
  final TextEditingController _codeController = new TextEditingController();

  void _handleSubmit() {
    if (onCodeSubmit != null) {
      onCodeSubmit(_codeController.text);
    }
    _codeController.clear();
  }

  Widget _buildForm() {
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
              onPressed: _handleSubmit,
              child: new Text("LET'S GET STARTED", style: TextStyle(color: Colors.white, fontSize: 16.0)),
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
