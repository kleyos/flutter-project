import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/new-project.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/services/api/base.dart';
import 'package:add_just/services/api/projects.dart';
import 'package:add_just/ui/projects/new-project-summary.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/common.dart';

class _NewProjectPersonState extends State<NewProjectPerson> {
  int _currentUserId;
  bool _isDataLoading = false;
  List<User> _users = [];

  Future<List<User>> _loadRegions() async {
    if (_users.isEmpty) {
      setState(() {
        _isDataLoading = true;
      });
      Projects projectService = new Projects();
      try {
        ApiResponse resp = await projectService.users(widget.account);
        _users = List.from(resp.data['users']).map((e) => User.fromApiResponse(e))
          .where((u) => u.isQS).toList();
        _currentUserId = _users[0]?.id;
      } catch (e) {
        showAlert(context, e.toString());
      } finally {
        setState(() {
          _isDataLoading = false;
        });
      }
    }
    return _users;
  }

  Function _submitPress() {
    return _isDataLoading ? null : () { _handleNext(); };
  }

  void changedDropDownItem(int selectedId) {
    setState(() {
      _currentUserId = selectedId;
    });
  }

  void _handleNext() {
    if (_currentUserId != null) {
      widget.project.user = _users.firstWhere((user) => user.id == _currentUserId);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext c) => new NewProjectSummary(
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
            items: snapshot.data.map((user) => new DropdownMenuItem<int>(
              value: user.id,
              child: new Text(user.displayName)
            )).toList(),
            onChanged: changedDropDownItem,
            value: _currentUserId,
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
              new Text('User', style: Themes.pageHeader2),
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

class NewProjectPerson extends StatefulWidget {
  NewProjectPerson({Key key, this.account, this.project}) : super(key: key);

  final Account account;
  final NewProject project;

  @override
  State<StatefulWidget> createState() => new _NewProjectPersonState();
}
