import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/new-project.dart';
import 'package:add_just/models/area.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/projects/new/new-project-person.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/common.dart';

class _NewProjectAreaState extends State<NewProjectArea> {
  int _currentAreaId;
  bool _isDataLoading = false;
  List<Area> _areas = [];
  final projectService = new ProjectPool();

  Future<List<Area>> _loadRegions() async {
    if (_areas.isEmpty) {
      setState(() {
        _isDataLoading = true;
      });

      try {
        _areas = await projectService.regions();
        _currentAreaId = _areas[0]?.id;
      } catch (e) {
        showAlert(context, e.toString());
      }
      finally {
        setState(() {
          _isDataLoading = false;
        });
      }
    }
    return _areas;
  }

  Function _submitPress() {
    return _isDataLoading ? null : () { _handleNext(); };
  }

  void changedDropDownItem(int selectedId) {
    setState(() {
      _currentAreaId = selectedId;
    });
  }

  void _handleNext() {
    if (_currentAreaId != null) {
      widget.newProject.region = _areas.firstWhere((area) => area.id == _currentAreaId);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext c) => new NewProjectPerson(
            newProject: widget.newProject
          ))
      );
    }
  }

  Widget _buildDropDown() {
    return new FutureBuilder(
      future: _loadRegions(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return new CircularProgressIndicator();
        } else {
          return new DropdownButton<int>(
            items: snapshot.data.map((area) => new DropdownMenuItem<int>(
              value: area.id,
              child: new Text(area.name)
            )).toList(),
            onChanged: changedDropDownItem,
            value: _currentAreaId,
          );
        }
      }
    );
  }

  Widget _buildForm() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new Column(
            children: <Widget>[
              new Text('Area', style: Themes.pageHeader2),
              new Text('Please enter project details to get started.',
                style: Themes.pageHeaderHint
              ),
              const SizedBox(height: 16.0),
              _buildDropDown()
            ]
          )
        ),
        new SingleActionButton(caption: 'NEXT', onPressed: _submitPress())
      ]
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
            child: _buildForm()
          )
        ]
      )
    );
  }
}

class NewProjectArea extends StatefulWidget {
  NewProjectArea({Key key, this.newProject}) : super(key: key);

  final NewProject newProject;

  @override
  State<StatefulWidget> createState() => new _NewProjectAreaState();
}
