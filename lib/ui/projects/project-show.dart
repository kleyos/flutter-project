import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/projects.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/projects/sections-list.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/themes.dart';

class _ProjectShowState extends State<ProjectShow> {
  Future<List<String>> _loadSections() async {
    try {
      Projects projectService = new Projects();
      return await projectService.sections(widget.account);
    } catch (e) {
      showAlert(context, e.toString());
    }
  }

  Widget _checkboxBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return new Center(child: CircularProgressIndicator());
    }
    return new SectionsList(account: widget.account, sections: snapshot.data);
  }

  void _handleAddSections() {
    showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (context) => new AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
        content: new Container(
//          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: new FutureBuilder(
            future: _loadSections(),
            builder: _checkboxBuilder
          )
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('SAVE'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.project.name),
        centerTitle: true
      ),
      body: new Stack(
        children: <Widget>[
          new BackgroundImage(),
          new Container(
            padding: const EdgeInsets.all(42.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('Start creating your scope of works by adding your first section below.',
                  style: Themes.pageHeader2, textAlign: TextAlign.center),
              ],
            )
          )
        ]
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () { _handleAddSections(); },
        tooltip: 'Add sections',
        child: new Icon(Icons.add),
      )
    );
  }
}

class ProjectShow extends StatefulWidget {
  ProjectShow({Key key, this.account, this.project}) : super(key: key);

  final Account account;
  final Project project;

  @override
  State<StatefulWidget> createState() => new _ProjectShowState();
}
