import 'dart:async';
import 'package:add_just/ui/projects/new/new-project-show.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:flutter/material.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/models/boq-items-container.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/sections/boq-item-set-action.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/sections/add-custom-scope-item-action.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/themes.dart';

class _BoqItemsSubcategoryListSate extends State<BoqItemsSubcategoryList> {
  final _scaffoldKey =  new GlobalKey<ScaffoldState>();
  final projectPool = new ProjectPool();

  void _categoryTap(BoqItemsCategory cat) {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _subcategoryTap(BoqItemsSubcategory sub) {
    Navigator.pop(context);
  }

  Future _onBoqItemAdded(BoqItem item, num quantity) async {
    try {
      await projectPool.addBoqItemToSection(
        widget.projectId, widget.projectSectionId, item.id, quantity);
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text('Added: $quantity ${item.measure} of ${item.name}')
        )
      );
    } catch (e) {
      showAlert(context, e.toString());
    }
  }

  void _handleGoToProject(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void _itemTap(BoqItem i) {
    showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (context) => new AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
        content: new Container(
//          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: new BoqItemSetAction(boqItem: i, onBoqItemAdded: _onBoqItemAdded)
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      )
    );
  }

  Widget _buildSubItem(String caption, GestureTapCallback onTap) {
    return new InkWell(
      onTap: onTap,
      child: new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(16.0),
            child: new Row(
              children: <Widget>[
                SizedBox(width: 24.0),
                new Expanded(child: Text(caption, style: Themes.boqCategoryTitle)),
                new Icon(Icons.chevron_right, color: Colors.teal)
              ]
            ),
          ),
          new Divider()
        ]
      )
    );
  }

  List<Widget> _buildSubs() {
    return widget.subcategory.items.map(
      (s) => _buildSubItem(s.name, () { _itemTap(s); })
    ).toList();
  }

  Widget _buildMainContent() {
    return new ListView(
      shrinkWrap: true,
      children: <Widget>[
        new Container(
          padding: EdgeInsets.all(16.0),
          child: new Column(
            children: <Widget>[
              new InkWell(
                onTap: () { _categoryTap(widget.category); },
                child: new Container(
                  padding: EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 16.0),
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.chevron_left, color: Colors.teal),
                      SizedBox(width: 8.0),
                      Text(widget.category.name, style: Themes.boqCategoryTitleHeader)
                    ]
                  )
                )
              ),
              new Divider(),
              new InkWell(
                onTap: () { _subcategoryTap(widget.subcategory); },
                child: new Container(
                  padding: EdgeInsets.fromLTRB(32.0, 16.0, 16.0, 16.0),
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.chevron_left, color: Colors.teal),
                      SizedBox(width: 8.0),
                      Text(widget.subcategory.name, style: Themes.boqCategoryTitleHeader)
                    ]
                  )
                )
              ),
              new Divider(),
              new Column(
                children: _buildSubs() +
                  [
                    AddCustomScopeItemAction(projectId: widget.projectId, sectionId: widget.projectSectionId)
                  ],
              )
            ],
          )
        ),
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
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new FutureBuilder(
          future: projectPool.getById(widget.projectId),
          builder: _buildTitle,
        ),
        centerTitle: true
      ),
      body: new Column(
        children: [
          new Expanded(
            flex: 1,
            child: new Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                new BackgroundImage(),
                _buildMainContent(),
              ]
            )
          ),
          new Container(
            margin: EdgeInsets.only(left: 25.0, right: 25.0),
            child: SingleActionButton(caption: "GO TO THE PROJECT",
            onPressed: () {_handleGoToProject(context);})
          )
        ]
      )
    );
  }
}

class BoqItemsSubcategoryList extends StatefulWidget {
  BoqItemsSubcategoryList({
    Key key,
    @required this.category,
    @required this.subcategory,
    @required this.projectId,
    @required this.projectSectionId
  }) : super(key: key);

  final BoqItemsCategory category;
  final BoqItemsSubcategory subcategory;
  final int projectId, projectSectionId;

  @override
  State<StatefulWidget> createState() => new _BoqItemsSubcategoryListSate();
}
