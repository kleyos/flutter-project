import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/projects.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/projects/project-show.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/chat/chat-index.dart';

class _ProjectListItemState extends State<ProjectListItem> {
  Project project;

  String get subtitle => "${project.location?.join(' ')} / ${Account.current.displayName}";

  Future<Project> _loadProject() async {
    try {
      Projects projectService = new Projects();
      return await projectService.load(widget.projectId);
    } catch (e) {
      showAlert(context, e.toString());
    }
    return null;
  }

  void _handleProjectTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => new ProjectShow(
      project: project,
    )));
  }

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

  Widget _buildCard() {
    return new Card(
      child: new InkWell(
        onTap: () { _handleProjectTap(context); },
        child: new Container(
          padding: const EdgeInsets.fromLTRB(24.0, 10.0, 10.0, 24.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _buildLid()
                ],
              ),
              new Text(project.name, style: Themes.projectListTitle),
              new Text(subtitle, style: Themes.projectListSubtitle)
            ],
          )
        )
      )
    );
  }

  Widget _widgetBuilder(BuildContext context, AsyncSnapshot<Project> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return new SizedBox();
    }
    project = snapshot.data;
    return _buildCard();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _loadProject(),
      builder: _widgetBuilder
    );
  }
}

class ProjectListItem extends StatefulWidget {
  ProjectListItem({Key key, @required this.projectId}) : super(key: key);

  final int projectId;

  @override
  State<StatefulWidget> createState() => new _ProjectListItemState();
}
