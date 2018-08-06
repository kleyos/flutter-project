import 'package:flutter/material.dart';

class ProjectsDrawer extends StatelessWidget {
  void _notImplemented(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new Container(
        padding: EdgeInsets.fromLTRB(41.0, 36.0, 41.0, 36.0),
        color: Colors.teal,
        child: new ListView(
          children: <Widget>[
            ListTile(
              title: Text('Active Projects', style: TextStyle(fontSize: 15.0, color: Colors.white)),
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                _notImplemented(context);
              },
            ),
            ListTile(
              title: Text('Completed Projects', style: TextStyle(fontSize: 15.0, color: Colors.white)),
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                _notImplemented(context);
              },
            ),
            new Divider(),
            ListTile(
              title: Text('Help', style: TextStyle(fontSize: 15.0, color: Colors.white)),
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                _notImplemented(context);
              },
            ),
            ListTile(
              title: Text('Contact Us', style: TextStyle(fontSize: 15.0, color: Colors.white)),
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                _notImplemented(context);
              },
            ),
            new Divider(),
            ListTile(
              title: Text('Log Out', style: TextStyle(fontSize: 15.0, color: Colors.white)),
              contentPadding: EdgeInsets.all(0.0),
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
