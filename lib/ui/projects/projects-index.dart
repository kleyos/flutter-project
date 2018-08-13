import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/services/api/base.dart';
import 'package:add_just/services/api/projects.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/projects/project-item.dart';
import 'package:add_just/ui/projects/projects-drawer.dart';
import 'package:add_just/ui/projects/new-project-start.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/common.dart';

class _ProjectsIndexState extends State<ProjectsIndex> {
  Future<List<dynamic>> _loadProjects() async {
    try {
      Projects projectService = new Projects();
      ApiResponse resp = await projectService.index(widget.account);
      return List.from(resp.data['projects']).map((p) =>
        ProjectItem(account: widget.account, project: Project.fromApiResponse(p))).toList();
    } catch (e) {
      showAlert(context, e);
    }
    return [];
  }

  void _handleAddNewProject() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext c) => new NewProjectStart(account: widget.account))
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

  Widget _buildMainContent() {
    return new FutureBuilder(
      future: _loadProjects(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return new Center(child: new CircularProgressIndicator());
        } else {
          return snapshot.data.isNotEmpty
            ? new Container(
                padding: const EdgeInsets.all(16.0),
                child: _listProjects(snapshot.data)
              )
            : new Container(
                padding: const EdgeInsets.all(42.0),
                child: _addNewProject()
              );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: AddJustTitle(fontSize: 25.0),
        centerTitle: true
      ),
      drawer: new ProjectsDrawer(account: widget.account),
      body: new Stack(
        children: <Widget>[
          new BackgroundImage(),
          _buildMainContent()
        ]
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _handleAddNewProject,
        tooltip: 'Add new project',
        child: new Icon(Icons.add),
      )
    );
  }
}

class ProjectsIndex extends StatefulWidget {
  ProjectsIndex({Key key, this.account}) : super(key: key);

  final Account account;

  @override
  State<StatefulWidget> createState() => new _ProjectsIndexState();
}
