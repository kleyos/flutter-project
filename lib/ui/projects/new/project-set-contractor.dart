import 'dart:async';
import 'package:add_just/ui/projects/new/project-setup-done.dart';
import 'package:flutter/material.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/services/api/project-pool.dart';
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
        _users = (await projectPool.users()).where((u) => u.isContractor).toList();
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
          return new Container(
            padding: EdgeInsets.fromLTRB(17.0, 3.0, 20.0, 3.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: DropdownButton<int>(
              items: snapshot.data.map((user) => new DropdownMenuItem<int>(
                value: user.id,
                child: new Text(user.displayName)
              )).toList(),
              onChanged: changedDropDownItem,
              value: _currentUserId,
            )
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
              new Text('Appoint Contractor',
                style: Themes.header),
              const SizedBox(height: 20.0),
              _buildDropDown()
            ]
          )
        ),
        new SingleActionButton(caption: 'CONFIRM', onPressed: _submitPress())
      ]
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(42.0),
      child: _buildForm()
    );
  }
}

class ProjectSetContractor extends StatefulWidget {
  ProjectSetContractor({Key key, this.projectId}) : super(key: key);

  final int projectId;

  @override
  State<StatefulWidget> createState() => new _ProjectSetContractorState();
}
