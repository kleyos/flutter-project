import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/projects/project-list-item.dart';
import 'package:add_just/ui/projects/projects-drawer.dart';
import 'package:add_just/ui/projects/new/new-project-start.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/common.dart';

class _ProjectsListState extends State<ProjectsList> {
  final projectPool = new ProjectPool();

  Future<List<ProjectListItem>> _loadProjects() async {
    try {
      List<Project> projects = await projectPool.index();
      return projects.map((p) => ProjectListItem(projectId: p.id)).toList();
    } catch (e) {
      showAlert(context, e.toString());
    }
    return [];
  }

  void _handleAddNewProject() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext c) => new NewProjectStart())
    );
  }

  Widget _listProjects(List<ProjectListItem> projects) {
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
      drawer: new ProjectsDrawer(account: Account.current),
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

class ProjectsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProjectsListState();
}
