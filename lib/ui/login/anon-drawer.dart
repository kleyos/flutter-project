import 'package:flutter/material.dart';

class AnonDrawer extends StatelessWidget {
  void _notImplemented(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
}
