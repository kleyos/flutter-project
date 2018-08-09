import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/new-project.dart';
import 'package:add_just/ui/projects/new-project-person.dart';
import 'package:add_just/models/area.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/services/api/base.dart';
import 'package:add_just/services/api/projects.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';

class _NewProjectAreaState extends State<NewProjectArea> {
  int _currentAreaId;
  List<Area> _areas = [];

  Future<List<Area>> _loadRegions() async {
    if (_areas.isEmpty) {
      Projects projectService = new Projects();
      try {
        ApiResponse resp = await projectService.regions(widget.account);
        _areas = List.from(resp.data['regions']).map((e) => Area.fromApiResponse(e)).toList();
        _currentAreaId = _areas[0]?.id;
      } catch (e) {
        print(e);
      }
    }
    return _areas;
  }

  void changedDropDownItem(int selectedId) {
    setState(() {
      _currentAreaId = selectedId;
    });
  }
  void _handleNext() {
    if (_currentAreaId != null) {
      widget.project.region = _areas.firstWhere((area) => area.id == _currentAreaId);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext c) => new NewProjectPerson(
            account: widget.account,
            project: widget.project
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
        new SingleActionButton(caption: 'NEXT', onPressed: _handleNext)
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
  NewProjectArea({Key key, this.account, this.project}) : super(key: key);

  final Account account;
  final NewProject project;

  @override
  State<StatefulWidget> createState() => new _NewProjectAreaState();
}
