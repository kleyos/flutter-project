import 'dart:async';

import 'package:add_just/models/user.dart';
import 'package:add_just/services/api/base.dart';
import 'package:add_just/services/api/projects.dart';
import 'package:flutter/material.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';

class _NewProjectAreaState extends State<NewProjectArea> {
  String _currentAreaId;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  bool _isDataLoaded = false;
  User _user = new User(accessToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMCwiZW1haWwiOiJ2aWFjaGVzbGF2LnBldHJlbmtvQGxpdHNsaW5rLmNvbSIsInJvbGUiOiJhbW8iLCJoYXNoIjoiNWFlMDVjYmQtMGJkNS00ODg1LTliMWYtZDhmOWU3NzdhZWI2Iiwib3JnX2lkIjoxLCJhdWQiOiJwb3N0Z3JhcGhpbGUiLCJpYXQiOjE1MzMyOTg2NDgsImV4cCI6MTU5NjQxMzg0OH0.bewHazaLjuepKOabh79xYOwrVZh2YZXQVhhqQqFhkWI', orgId: 1);

  Future<List<Map<String, String>>> _loadRegions() async {
    Projects projectService = new Projects(baseURL: 'https://api.staging.termpay.io/api');
    try {
      ApiResponse resp = await projectService.index(_user);
      return resp.data['regions'];
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _loadRegions().then((val) {
      _dropDownMenuItems = val.map((e) =>
        new DropdownMenuItem<String>(value: e['id'], child: new Text(e['name']))
      );
      _currentAreaId = _dropDownMenuItems[0].value;
      _isDataLoaded = true;
     });
    super.initState();
  }

  void changedDropDownItem(String selectedId) {
    setState(() {
      _currentAreaId = selectedId;
    });
  }

  Widget _buildForm() {
    return new Form(
      child: new Column(
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
                _isDataLoaded ?
                new DropdownButton(
                  value: _currentAreaId,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ) : SizedBox()
              ]
            )
          ),
          new SingleActionButton(caption: 'NEXT', onPressed: null)
        ]
      )
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
  @override
  State<StatefulWidget> createState() => new _NewProjectAreaState();
}


