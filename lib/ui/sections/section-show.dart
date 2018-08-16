import 'package:add_just/models/account.dart';
import 'package:add_just/models/project-section.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/themes.dart';
import 'package:flutter/material.dart';

class _SectionShowState extends State<SectionShow> {

  void _handleAddItem() {

  }

  Widget _buildSection() {
    return new Column(
      children: widget.projectSection.scopeItems.map((i) => new Text(i.name)).toList()
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
            padding: EdgeInsets.all(32.0),
            child: _buildMainContent()
          )
        ]
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () { _handleAddItem(); },
        tooltip: 'Add sections',
        child: new Icon(Icons.add),
      )
    );

  }
}

class SectionShow extends StatefulWidget {
  SectionShow({
    Key key,
    @required this.account,
    @required this.project,
    @required this.projectSection
  }) : super(key: key);

  final Account account;
  final Project project;
  final ProjectSection projectSection;

  @override
  State<StatefulWidget> createState() => new _SectionShowState();
}
