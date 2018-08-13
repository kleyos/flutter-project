import 'package:flutter/material.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/ui/themes.dart';

class ProjectsDrawer extends StatelessWidget {
  ProjectsDrawer({Key key, this.account}) : super(key: key);

  final Account account;

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
              title: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Dublin City Council', style: Themes.drawerMenuHeader),
                  Text(account.displayName, style: Themes.drawerMenuItem),
                ],
              ),
              contentPadding: EdgeInsets.all(0.0)
            ),
            new Divider(),
            ListTile(
              title: Text('Active Projects', style: Themes.drawerMenuItem),
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                _notImplemented(context);
              },
            ),
            ListTile(
              title: Text('Completed Projects', style: Themes.drawerMenuItem),
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                _notImplemented(context);
              },
            ),
            new Divider(),
            ListTile(
              title: Text('Help', style: Themes.drawerMenuItem),
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                _notImplemented(context);
              },
            ),
            ListTile(
              title: Text('Contact Us', style: Themes.drawerMenuItem),
              contentPadding: EdgeInsets.all(0.0),
              onTap: () {
                _notImplemented(context);
              },
            ),
            new Divider(),
            ListTile(
              title: Text('Log Out', style: Themes.drawerMenuItem),
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
