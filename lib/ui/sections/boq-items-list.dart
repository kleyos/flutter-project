import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/boq-items-container.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/services/api/essentials.dart';
import 'package:add_just/ui/sections/boq-items-category-list.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/shared/background-image.dart';

class _BoqItemsListState extends State<BoqItemsList> {
  BoqItemsContainer _boqItemsContainer;

  Future<BoqItemsContainer> _loadItems() async {
    if (_boqItemsContainer == null) {
      try {
        Essentials eService = new Essentials();
        _boqItemsContainer = await eService.loadBoqItems(widget.account);
      } catch (e) {
        showAlert(context, e.toString());
      }
    }
    return _boqItemsContainer;
  }

  void _categoryTap(BoqItemsCategory cat) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (c) => new BoqItemsCategoryList(
        category: cat, projectName: widget.project.name
      ))
    );
  }

  Widget _buildCategory(BoqItemsCategory cat) {
    return new InkWell(
      onTap: () { _categoryTap(cat); },
      child: new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(16.0),
            child: new Row(
              children: <Widget>[
                SizedBox(width: 24.0),
                Text(cat.name, style: Themes.boqCategoryTitle),
                new Expanded(child: new SizedBox()),
                new Icon(Icons.chevron_right, color: Colors.teal)
              ]
            ),
          ),
          new Divider()
        ]
      )
    );
  }

  Widget _buildItems(BuildContext context, AsyncSnapshot<BoqItemsContainer> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return new Center(child: new CircularProgressIndicator());
    }
    if (snapshot.data == null) {
      return new Center(child: new Text('No items loaded'));
    }
    return new Column(children: snapshot.data.categories.map((c) => _buildCategory(c)).toList());
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
