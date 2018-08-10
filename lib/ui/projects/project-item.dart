import 'package:flutter/material.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/project.dart';

class ProjectItem extends StatelessWidget {
  ProjectItem({
    Key key,
    this.account,
    this.project
  }) : super(key: key);

  final Project project;
  final Account account;

  String get subtitle => "${project.location?.join(' ')} / ${account.displayName}";

  Widget _buildLid() {
    return new Container(
      width: 10.0,
      height: 10.0,
      decoration: new BoxDecoration(
        color: Color.fromRGBO(0, 150, 136, 1.0),
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
        padding: const EdgeInsets.fromLTRB(24.0, 10.0, 10.0, 24.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[_buildLid()],
            ),
            new Text(project.name, style: Themes.projectListTitle),
            new Text(subtitle, style: Themes.projectListSubtitle)
          ],
        )
      )
    );
  }
}
