import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/projects/new/new-project-show.dart';
import 'package:add_just/ui/projects/project-show.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/themes.dart';

class _ProjectListItemState extends State<ProjectListItem> {
  final projectPool = new ProjectPool();

  Future<Project> _loadProject() async {
    try {
      return await projectPool.getById(widget.projectId);
    } catch (e) {
      showAlert(context, e.toString());
    }
    return null;
  }

  void _handleProjectTap(Project project) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => project.isNew
      ? new NewProjectShow(projectId: widget.projectId)
      : new ProjectShow(projectId: widget.projectId)
    ));
  }

  Widget _buildLid(String status) {
    return new Container(
      width: 10.0,
      height: 10.0,
      decoration: new BoxDecoration(
        color: Themes.statusStyling[status]['color'],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildCard(Project project) {
    String subtitle = "${project.address?.join(' ')} / ${Account.current.displayName}";
    return new Card(
      child: new InkWell(
        onTap: () { _handleProjectTap(project); },
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
                  _buildLid(project.status)
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
    return _buildCard(snapshot.data);
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
