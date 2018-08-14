import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/services/api/projects.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/themes.dart';

class _ProjectShowState extends State<ProjectShow> {
  List<String> _selectedSections = [];
  List<String> _sections = [];

  Future<List<String>> _loadSections() async {
    if (_sections.isEmpty) {
      try {
        Projects projectService = new Projects();
        _sections = await projectService.sections(widget.account);
      } catch (e) {
        showAlert(context, e.toString());
      }
    }
    return _sections;
  }

  Widget _checkboxBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    print('rebuild');

    if (snapshot.connectionState != ConnectionState.done) {
      return new Center(child: CircularProgressIndicator());
    }
    

    List<Widget> items = List.from(snapshot.data).map((l) => new Column(
      children: <Widget>[
        new CheckboxListTile(
          title: new Text(l),
          value: _selectedSections.contains(l),
          onChanged: (bool value) {
            print(_selectedSections);
            print(value);
            setState(() {
              if (value) {
                _selectedSections.contains(l) ? _selectedSections.remove(l) : _selectedSections.add(l);
              }
            });
          }
        ),
        new Divider()
      ],
    )).toList();
    items.add(new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new FlatButton(
          onPressed: null,
          child: new Text('Add new', textAlign: TextAlign.left, style: Themes.popupDialogAction)
        ),
        new Divider()
      ],
    ));

    return new Expanded(
      flex: 1,
        child: new ListView(
          shrinkWrap: true,
          children: items
      )
    );
  }

  Widget _buildOpts() {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new FutureBuilder(
          future: _loadSections(),
          builder:  _checkboxBuilder
        ),
      ]
    );
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
          child: _buildOpts()
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
