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
  int _currentAreaId;
  User _user = new User(accessToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMCwiZW1haWwiOiJ2aWFjaGVzbGF2LnBldHJlbmtvQGxpdHNsaW5rLmNvbSIsInJvbGUiOiJhbW8iLCJoYXNoIjoiNWFlMDVjYmQtMGJkNS00ODg1LTliMWYtZDhmOWU3NzdhZWI2Iiwib3JnX2lkIjoxLCJhdWQiOiJwb3N0Z3JhcGhpbGUiLCJpYXQiOjE1MzMyOTg2NDgsImV4cCI6MTU5NjQxMzg0OH0.bewHazaLjuepKOabh79xYOwrVZh2YZXQVhhqQqFhkWI', orgId: 1);

  Future<List<Map<String, dynamic>>> _loadRegions() async {
    Projects projectService = new Projects(baseURL: 'api.staging.termpay.io');
    try {
      ApiResponse resp = await projectService.regions(_user);
      return resp != null ? resp.data['regions'] : [];
    } catch (e) {
      print(e);
    }
    return [];
  }

  void changedDropDownItem(int selectedId) {
    _currentAreaId = selectedId;
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
                new FutureBuilder(
                  future: _loadRegions(),
                  builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return new Text('Loading...');
                    } else {
                      return new DropdownButton<int>(
                        items: snapshot.data.map((Map<String, dynamic> row) => new DropdownMenuItem<int>(
                          value: row['id'],
                          child: new Text(row['name'])
                        )).toList(),
                        onChanged: changedDropDownItem
                      );
                    }
                  }
                )
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


