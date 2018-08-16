import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/boq-items-container.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/services/api/essentials.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/shared/background-image.dart';

class _BoqItemsListState extends State<BoqItemsList> {

  Future<BoqItemsContainer> _loadItems() async {
    try {
      Essentials eService = new Essentials();
      return new BoqItemsContainer(items: await eService.loadBoqItems(widget.account));
    } catch (e) {
      showAlert(context, e.toString());
    }
  }

  Widget _buildCategory(String name) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.all(12.0),
          child: new Row(
            children: <Widget>[
              Text(name, style: Themes.projectSectionTitle),
              new Expanded(child: new SizedBox()),
              new Icon(Icons.chevron_right, color: Colors.teal)
            ]
          ),
        ),
        new Divider()
      ]
    );
  }

  Widget _buildItems(BuildContext context, AsyncSnapshot<BoqItemsContainer> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return new Center(child: new CircularProgressIndicator());
    }
    return new Column(children: snapshot.data.categories.map((i) => _buildCategory(i)).toList());
  }

  Widget _buildMainContent() {
    return new FutureBuilder(
      future: _loadItems(),
      builder: _buildItems
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
          _buildMainContent()
        ]
      )
    );
  }
}

class BoqItemsList extends StatefulWidget {
  BoqItemsList({
    Key key,
    @required this.account,
    @required this.project
  }) : super(key: key);

  final Account account;
  final Project project;
  @override
  State<StatefulWidget> createState() => new _BoqItemsListState();
}
