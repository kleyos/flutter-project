import 'package:flutter/material.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/projects/projects-list.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';

class _NewProjectFinishState extends State<NewProjectFinish> {
  final projectPool = new ProjectPool();

  void _handleGoToProjectsList(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ProjectsList())
    );
  }

  Widget _buildProject(BuildContext ctx, AsyncSnapshot<Project> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return new Center(child: new CircularProgressIndicator());
    }
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Expanded(
          child: new Column(
            children: <Widget>[
              new SizedBox(height: 42.0),
              new Image(
                width: 150.0,
                height: 150.0,
                fit: BoxFit.cover,
                image: new AssetImage('assets/images/circular-check-button.png')
              ),
              new SizedBox(height: 32.0),
              new Text("${snapshot.data.name} has been added to project list",
                style: Themes.pageHeader2, textAlign: TextAlign.center),
            ]
          )
        ),
        new SingleActionButton(caption: 'GO TO PROJECTS LIST',
          onPressed: () { _handleGoToProjectsList(ctx); }),
      ],
    );
  }

  Widget _buildMainContent() {
    return new FutureBuilder(
      future: projectPool.getById(widget.projectId),
      builder: _buildProject
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: AddJustTitle(),
        centerTitle: true
      ),
      body: new Stack(
        children: <Widget>[
          new BackgroundImage(),
          new Container(
            padding: const EdgeInsets.all(42.0),
            child: _buildMainContent()
          )
        ]
      )
    );
  }
}

class NewProjectFinish extends StatefulWidget {
  NewProjectFinish({Key key, this.projectId}) : super(key: key);

  final int projectId;

  @override
  State<StatefulWidget> createState() => new _NewProjectFinishState();
}
