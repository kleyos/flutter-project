import 'dart:async';
import 'package:add_just/models/project.dart';
import 'package:add_just/ui/projects/project-setup-done.dart';
import 'package:flutter/material.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/common.dart';

class _ProjectSetContractorState extends State<ProjectSetContractor> {
  int _currentUserId;
  bool _isDataLoading = false;
  List<User> _users = [];
  final projectPool = new ProjectPool();

  Future<List<User>> _loadUsers() async {
    if (_users.isEmpty) {
      setState(() {
        _isDataLoading = true;
      });
      try {
        _users = await projectPool.users();
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

  void _handleNext() async {
    if (_currentUserId != null) {
      await projectPool.finaliseScope(widget.projectId, _currentUserId);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext c) => new ProjectSetupDone()
        )
      );
    }
  }

  Widget _buildDropDown() {
    return new FutureBuilder(
      future: _loadUsers(),
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
              new Text('Appoint Contractor', style: Themes.pageHeader2),
              const SizedBox(height: 16.0),
              _buildDropDown()
            ]
          )
        ),
        new SingleActionButton(caption: 'CONFIRM', onPressed: _submitPress())
      ]
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
            padding: const EdgeInsets.all(42.0),
            child: _buildForm()
          )
        ]
      )
    );
  }
}

class ProjectSetContractor extends StatefulWidget {
  ProjectSetContractor({Key key, this.projectId}) : super(key: key);

  final int projectId;

  @override
  State<StatefulWidget> createState() => new _ProjectSetContractorState();
}
