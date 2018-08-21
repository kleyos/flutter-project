import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_just/models/boq-items-container.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/essentials.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/sections/boq-items-category-list.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/shared/background-image.dart';

class _BoqItemsListState extends State<BoqItemsList> {
  final projectPool = new ProjectPool();
  BoqItemsContainer _boqItemsContainer;

  Future<BoqItemsContainer> _loadItems() async {
    if (_boqItemsContainer == null) {
      try {
        Essentials eService = new Essentials();
        _boqItemsContainer = await eService.loadBoqItems();
      } catch (e) {
        showAlert(context, e.toString());
      }
    }
    return _boqItemsContainer;
  }

  void _categoryTap(BoqItemsCategory cat) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (c) => new BoqItemsCategoryList(
        category: cat, projectId: widget.projectId, projectSectionId: widget.projectSectionId,
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
    return new Container(
      padding: EdgeInsets.only(top: 8.0),
      child: new Column(
        children: snapshot.data.categories.map((c) => _buildCategory(c)).toList()
      )
    );
  }

  Widget _buildMainContent() {
    return new ListView(
      shrinkWrap: true,
      children: <Widget>[
        FutureBuilder(
          future: _loadItems(),
          builder: _buildItems
        )
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
          _buildMainContent()
        ]
      )
    );
  }
}

class BoqItemsList extends StatefulWidget {
  BoqItemsList({
    Key key,
    @required this.projectId,
    @required this.projectSectionId
  }) : super(key: key);

  final int projectId, projectSectionId;

  @override
  State<StatefulWidget> createState() => new _BoqItemsListState();
}
