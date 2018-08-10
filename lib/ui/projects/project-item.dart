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

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(4.0))
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(project.name, style: Themes.projectListTitle),
          Text("${project.location?.join(' ')} / ${account.displayName}")
        ],
      ),
    );
  }
}
