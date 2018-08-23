import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/project-section.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/projects/project-set-contractor.dart';
import 'package:add_just/ui/projects/project-section-item.dart';
import 'package:add_just/ui/projects/popup-sections-list.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/themes.dart';

class _ProjectShowState extends State<ProjectShow> {
  List<String> _selectedSections;
  List<ProjectSection> _existingSections = [];
  List<String> _availableSections = [];
  final projectPool = new ProjectPool();
  bool _isSectionsNeedReload = false;

  bool isSectionAlreadyAdded(String name) {
    return _existingSections.firstWhere((s) => s.name == name, orElse: () => null) != null;
  }

  Future<List<String>> _loadAvailableSections() async {
    try {
      _availableSections = await projectPool.availableSections();
      _availableSections.removeWhere((name) => isSectionAlreadyAdded(name));
    } catch (e) {
      showAlert(context, e.toString());
    }
    return _availableSections;
  }

  Future<List<ProjectSection>> _loadSections() async {
    try {
      Project p = await projectPool.getById(widget.projectId);
      _existingSections = p.sections;
      _isSectionsNeedReload = false;
    } catch (e) {
      showAlert(context, e.toString());
    }
    return _existingSections;
  }

  Future<Project> _saveSectionsToProject() async {
    Project p;
    try {
      p = await projectPool.addSectionsToProject(_selectedSections, widget.projectId);
      setState(() {
        _isSectionsNeedReload = true;
      });
    } catch (e) {
      showAlert(context, e.toString());
    }
    return p;
  }

  void _handleScopeFinalise() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ProjectSetContractor(projectId: widget.projectId))
    );
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

  Widget _buildFinaliseButton() {
    return new FutureBuilder(
      future: projectPool.getById(widget.projectId),
      builder: (BuildContext ctx, AsyncSnapshot<Project> s) {
        if (s.connectionState != ConnectionState.done) {
          return new SizedBox();
        }
        if (s.data.canFinaliseScopes) {
          new InkWell(
            onTap: () { _handleScopeFinalise(); },
            child: new Container(
              padding: EdgeInsets.all(12.0),
              color: Colors.teal,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('FINALISE SCOPE OF WORK', style: Themes.buttonCaption, textAlign: TextAlign.center)
                ],
              )
            )
          );
        }
        return new SizedBox();
      }
    );
  }

  Widget _buildFloatingActionButton() {
    return new FloatingActionButton(
      onPressed: () { _handleAddSections(); },
      tooltip: 'Add sections',
      child: new Icon(Icons.add)
    );
  }

  Widget _buildFloatingActionButtonHolder() {
    return new FutureBuilder(
      future: projectPool.getById(widget.projectId),
      builder: (BuildContext ctx, AsyncSnapshot<Project> s) {
        if (s.connectionState != ConnectionState.done) {
          return new SizedBox();
        }
        return s.data.canFinaliseScopes
          ? new Container(
              padding: EdgeInsets.only(bottom: 40.0),
              child: _buildFloatingActionButton()
            )
          : _buildFloatingActionButton();
      }
    );
  }

  Widget _sectionsBuilder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return new Center(child: CircularProgressIndicator());
    }

    if (List.from(snapshot.data).isNotEmpty) {
      return new Column(
        children: <Widget>[
          new Expanded(
            child: new ListView(
              shrinkWrap: true,
              children: new List.from(snapshot.data).map((e) =>
                new ProjectSectionItem(projectId: widget.projectId, projectSectionId: e.id)
              ).toList()
            ),
          ),
          _buildFinaliseButton()
        ]
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

  Widget _buildTitle(BuildContext ctx, AsyncSnapshot<Project> sn) {
    if (sn.connectionState != ConnectionState.done) {
      return new SizedBox();
    }
    return new Text(sn.data.name);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new FutureBuilder(
          future: projectPool.getById(widget.projectId),
          builder: _buildTitle,
        ),
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
      floatingActionButton: _buildFloatingActionButtonHolder()
    );
  }
}

class ProjectShow extends StatefulWidget {
  ProjectShow({Key key, this.projectId}) : super(key: key);

  final int projectId;

  @override
  State<StatefulWidget> createState() => new _ProjectShowState();
}
