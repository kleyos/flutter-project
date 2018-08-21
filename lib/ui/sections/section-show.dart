import 'package:add_just/ui/sections/section-list-item.dart';
import 'package:flutter/material.dart';
import 'package:add_just/models/section-item.dart';
import 'package:add_just/models/project-section.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/ui/sections/boq-items-list.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/themes.dart';

class _SectionShowState extends State<SectionShow> {

  void _handleAddItem() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext c) => new BoqItemsList(
        project: widget.project, projectSection: widget.projectSection
      )
    ));
  }

  Widget _buildSectionItem(SectionItem item) {
    return new SectionListItem(sectionItem: item);
  }

  Widget _buildSectionHeader(String text) {
    return new Container(
      padding: EdgeInsets.all(16.0),
      color: new Color.fromRGBO(224, 224, 224, 1.0),
      child: new Row(
        children: <Widget>[
          new Text(text.toUpperCase(), style: Themes.projectSectionTitle)
        ]
      )
    );
  }

  Widget _buildSection() {
    return new Column(
      children: <Widget>[
        _buildSectionHeader(widget.projectSection.name),
        new Container(
          padding: EdgeInsets.all(16.0),
          child: new Column(
            children: widget.projectSection.scopeItems.map((i) => _buildSectionItem(i)).toList(),
          )
        )
      ]
    );
  }

  Widget _buildMainContent() {
    return widget.projectSection.isEmpty
      ? new Center(
        child: new Text('Add the first item to this section',
          style: Themes.pageHeader2, textAlign: TextAlign.center)
        )
      : _buildSection();
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
          new Container(
            child: _buildMainContent()
          )
        ]
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () { _handleAddItem(); },
        tooltip: 'Add item',
        child: new Icon(Icons.add),
      )
    );
  }
}

class SectionShow extends StatefulWidget {
  SectionShow({
    Key key,
    @required this.project,
    @required this.projectSection
  }) : super(key: key);

  final Project project;
  final ProjectSection projectSection;

  @override
  State<StatefulWidget> createState() => new _SectionShowState();
}
