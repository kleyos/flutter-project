import 'package:flutter/material.dart';

typedef void OnLoginCallback(String username, String pwd);

class SignIn extends StatelessWidget {
  SignIn({
    Key key,
    this.onLogin
  }) : super(key: key);

  final OnLoginCallback onLogin;
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _pwdController = new TextEditingController();

  void _handleSignIn() {
    if (onLogin != null) {
      onLogin(_usernameController.text, _pwdController.text);
    }
    _usernameController.clear();
    _pwdController.clear();
  }

  void _notImplemented(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
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
            controller: _usernameController,
          ),
          const SizedBox(height: 10.0),
          new TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              filled: true,
              labelText: 'Password'
            ),
            obscureText: true,
            controller: _pwdController,
          ),
          const SizedBox(height: 30.0),
          new SizedBox(
            width: double.infinity,
            height: 50.0,
            child: new FlatButton(
              onPressed: _handleSignIn,
              child: new Text("Let's get started", style: TextStyle(color: Colors.white, fontSize: 16.0)),
              color: Colors.teal
            )
          )
        ]
      )
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return new Drawer(
      child: new Container(
        padding: EdgeInsets.all(54.0),
        color: Colors.black38,
        child: new ListView(
          children: <Widget>[
            ListTile(
              title: Text('About'),
              onTap: () {
                _notImplemented(context);
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                _notImplemented(context);
              },
            ),
            new Divider(),
            ListTile(
              title: Text('Contact Us'),
              onTap: () {
                _notImplemented(context);
              },
            ),
            ListTile(
              title: Text('Terms Of Service'),
              onTap: () {
                _notImplemented(context);
              },
            ),
            new Divider(),
            ListTile(
              title: Text('Log in'),
              onTap: () {
                _notImplemented(context);
              },
            ),
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('+AddJust'),
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),
        drawer: _buildDrawer(context),
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
      )
    );
  }
}
