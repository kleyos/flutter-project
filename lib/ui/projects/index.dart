import 'dart:async';

import 'package:flutter/material.dart';
import 'package:add_just/services/api/base.dart';
import 'package:add_just/services/api/projects.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/projects/project-item.dart';
import 'package:add_just/ui/projects/projects-drawer.dart';
import 'package:add_just/ui/projects/new-project-start.dart';
import 'package:add_just/ui/shared/add-just-title.dart';

class _ProjectsIndexState extends State<ProjectsIndex> {
  Future<List<dynamic>> _loadProjects() async {
    try {
      Projects projectService = new Projects();
      ApiResponse resp = await projectService.index(widget.user);
      return List.from(resp.data['projects']).map((p) =>
        ProjectItem(project: Project.fromApiResponse(p))).toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  void _handleAddNewProject() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext c) => new NewProjectStart(user: widget.user))
    );
  }

  Widget _listProjects(List<ProjectItem> projects) {
    return new ListView.builder(
      padding: new EdgeInsets.all(8.0),
      reverse: false,
      itemBuilder: (_, int idx) => projects[idx],
      itemCount: projects.length
    );
  }

  Widget _addNewProject() {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('Welcome to', style: TextStyle(fontSize: 30.0)),
          new Center(child: AddJustTitle()),
          const SizedBox(height: 58.0),
          SingleActionButton(caption: '+ADD NEW PROJECT', onPressed: _handleAddNewProject),
          const SizedBox(height: 58.0 + 60.0),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: AddJustTitle(fontSize: 25.0),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      drawer: ProjectsDrawer(),
      body: new Stack(
        children: <Widget>[
          new BackgroundImage(),
          new Container(
            padding: const EdgeInsets.only(left: 52.0, right: 52.0),
            child: new FutureBuilder(
              future: _loadProjects(),
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return new Center(child: new CircularProgressIndicator());
                } else {
                  return snapshot.data.isNotEmpty
                    ? _listProjects(snapshot.data)
                    : _addNewProject();
                }
              }
            )
          )
        ]
      )
    );
  }
}

class ProjectsIndex extends StatefulWidget {
  ProjectsIndex({Key key, this.user}) : super(key: key);

  final User user;

  @override
  State<StatefulWidget> createState() => new _ProjectsIndexState();
}
