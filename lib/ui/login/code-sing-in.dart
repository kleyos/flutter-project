import 'package:add_just/ui/login/anon-drawer.dart';
import 'package:flutter/material.dart';

typedef void OnCodeRequestCallback(String email);

class CodeSignIn extends StatelessWidget {
  CodeSignIn({
    Key key,
    this.onCodeRequest
  }) : super(key: key);

  final OnCodeRequestCallback onCodeRequest;
  final TextEditingController _emailController = new TextEditingController();

  void _handleSignIn() {
    if (onCodeRequest != null) {
      onCodeRequest(_emailController.text);
    }
    _emailController.clear();
  }

  Widget _buildForm() {
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
              onPressed: _handleSignIn,
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
