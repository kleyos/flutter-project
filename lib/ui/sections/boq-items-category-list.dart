import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:add_just/models/boq-items-container.dart';

class _BoqItemsCategoryListSate extends State<BoqItemsCategoryList> {
  void _categoryTap(BoqItemsCategory cat) {
    Navigator.pop(context);
  }

  void _subTap(BoqItemsSubCategory sub) {
    print(sub.name);
  }

  List<Widget> _buildSubs() {
    return widget.category.subCategories.map((s) => new InkWell(
      onTap: () { _subTap(s); },
      child: new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(16.0),
            child: new Row(
              children: <Widget>[
                SizedBox(width: 24.0),
                Text(s.name, style: Themes.boqCategoryTitle),
                new Expanded(child: new SizedBox()),
                new Icon(Icons.chevron_right, color: Colors.teal)
              ]
            ),
          ),
          new Divider()
        ]
      )
    )).toList();
  }

  Widget _buildMainContent() {
    return new Column(
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
              new Column(
                children: _buildSubs(),
              )
            ],
          )
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.projectName),
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

class BoqItemsCategoryList extends StatefulWidget {
  BoqItemsCategoryList({
    Key key,
    @required this.category,
    @required this.projectName
  }) : super(key: key);

  final BoqItemsCategory category;
  final String projectName;

  @override
  State<StatefulWidget> createState() => new _BoqItemsCategoryListSate();
}
