import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/project-section.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/base.dart';
import 'package:add_just/services/api/projects.dart';
import 'package:add_just/ui/projects/project-section-item.dart';
import 'package:add_just/ui/projects/popup-sections-list.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/themes.dart';

class _ProjectShowState extends State<ProjectShow> {
  List<String> _selectedSections;
  List<ProjectSection> _existingSections = [];
  List<String> _availableSections = [];
  Projects projectService = new Projects();
  bool _isSectionsNeedReload = false;

  bool isSectionAlreadyAdded(String name) {
    return _existingSections.firstWhere((s) => s.name == name, orElse: () => null) != null;
  }

  Future<List<String>> _loadAvailableSections() async {
    try {
      _availableSections = await projectService.availableSections();
      _availableSections.removeWhere((name) => isSectionAlreadyAdded(name));
      return _availableSections;
    } catch (e) {
      showAlert(context, e.toString());
    }
  }

  Future<List<ProjectSection>> _loadSections() async {
    try {
      Project p = await projectService.load(widget.project.id);
      _existingSections = p.sections;
      _isSectionsNeedReload = false;
      return _existingSections;
    } catch (e) {
      showAlert(context, e.toString());
    }
  }

  Future<ApiResponse> _saveSectionsToProject() async {
    try {
      ApiResponse resp = await projectService.addSectionsToProject(_selectedSections, widget.project.id);
      widget.project.sections = (await projectService.load(widget.project.id)).sections;
      setState(() {
        _isSectionsNeedReload = true;
      });
      return resp;
    } catch (e) {
      showAlert(context, e.toString());
    }
  }

  Widget _checkboxBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return new Center(child: CircularProgressIndicator());
    }
    return new PopupSectionsList(
      sections: snapshot.data,
      onSelectedItemsChanges: (List<String> items) {
        _selectedSections = items;
      },
    );
  }

  Widget _sectionsBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return new Center(child: CircularProgressIndicator());
    }

    if (List.from(snapshot.data).isNotEmpty) {
      return new Column(
        children: new List.from(snapshot.data).map((e) =>
          new ProjectSectionItem(project: widget.project, projectSection: e)
        ).toList()
      );
    } else {
      return new Container(
        padding: EdgeInsets.all(32.0),
        child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Start creating your scope of works by adding your first section below.',
              style: Themes.pageHeader2, textAlign: TextAlign.center)
          ]
        )
      );
    }
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
            future: _loadAvailableSections(),
            builder: _checkboxBuilder
          )
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('SAVE'),
            onPressed: () {
              Navigator.of(context).pop();
              if (_selectedSections.isNotEmpty) {
                _saveSectionsToProject();
              }
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
            child: new FutureBuilder(
              future: _loadSections(),
              builder: _sectionsBuilder
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
  ProjectShow({Key key, this.project}) : super(key: key);

  final Project project;

  @override
  State<StatefulWidget> createState() => new _ProjectShowState();
}
