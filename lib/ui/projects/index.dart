import 'package:flutter/material.dart';
import 'package:add_just/services/api/base.dart';
import 'package:add_just/services/api/projects.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/ui/projects/project-item.dart';

class _ProjectsIndexState extends State<ProjectsIndex> {
  final List<ProjectItem> _projects = <ProjectItem>[];

  void _loadProjects() {
    Projects projectService = new Projects(baseURL: 'https://api.staging.termpay.io/api');
    projectService.index(widget.user).then((ApiResponse resp) {
//      if (resp.isError) {
//        // show error
//      } else {
//        List.from(resp.data['projects']).forEach((p) {
//          setState(() {
//            _projects.add(ProjectItem(project: Project.fromApiResponse(p)));
//          });
//        });
//      }
    });
  }

//  @override
//  void initState() {
//    super.initState();
//    _loadProjects();
//  }

  Widget _listProjects() {
    return new ListView.builder(
      padding: new EdgeInsets.all(8.0),
      reverse: false,
      itemBuilder: (_, int idx) => _projects[idx],
      itemCount: _projects.length
    );
  }

  Widget _addNewProject() {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('Welcome to'),
          new Text('+AddJust'),
          new RaisedButton(
            child: new Text("+ADD YOUR FIRST PROJET",
              style: TextStyle(color: Colors.white, fontSize: 16.0)
            ),
            onPressed: null
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('+AddJust'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: _projects.isNotEmpty ? _listProjects() : _addNewProject()
    );
  }
}

class ProjectsIndex extends StatefulWidget {
  ProjectsIndex({
    Key key,
    this.user
  }) : super(key: key);

  final User user;

  @override
  State<StatefulWidget> createState() => new _ProjectsIndexState();
}
