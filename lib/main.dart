import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/ui/login/code-sign-in.dart';
import 'package:add_just/ui/projects/index.dart';
import 'package:add_just/services/prefs.dart';

void main() {
  runApp(new AddJustApp());
}

class _AddJustAppState extends State<AddJustApp> {
  Account _account;

  Future<Account> _loadAccount() async {
    if (_account == null) {
      PrefsService prefs = new PrefsService();
      _account = await prefs.restoreSession();
    }
    return _account;
  }

  @override
  void initState() {
    _loadAccount().then((a) => setState(() {_account = a; }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '+AddJust',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
        backgroundColor: Colors.blueGrey,
        scaffoldBackgroundColor: Color.fromRGBO(242, 242, 242, 1.0)
      ),
      routes: {
  //        '/': (BuildContext context) => ProjectsIndex(account: new Account(accessToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMCwiZW1haWwiOiJ2aWFjaGVzbGF2LnBldHJlbmtvQGxpdHNsaW5rLmNvbSIsInJvbGUiOiJhbW8iLCJoYXNoIjoiNWFlMDVjYmQtMGJkNS00ODg1LTliMWYtZDhmOWU3NzdhZWI2Iiwib3JnX2lkIjoxLCJhdWQiOiJwb3N0Z3JhcGhpbGUiLCJpYXQiOjE1MzMyOTg2NDgsImV4cCI6MTU5NjQxMzg0OH0.bewHazaLjuepKOabh79xYOwrVZh2YZXQVhhqQqFhkWI', orgId: 1))
        '/': (BuildContext context) => _account != null ? ProjectsIndex(account: _account) : CodeSignIn()
      }
    );
  }
}

class AddJustApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AddJustAppState();
}
