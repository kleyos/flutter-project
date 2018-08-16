import 'package:add_just/models/account.dart';
import 'package:add_just/models/project-section.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:flutter/material.dart';

class _SectionIndexState extends State<SectionIndex> {

  void _handleAddNewItem() {

  }

  Widget _buildMainContent() {
    return new SizedBox();
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
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _handleAddNewItem,
        tooltip: 'Add new item',
        child: new Icon(Icons.add),
      ),
    );
  }
}

class SectionIndex extends StatefulWidget {
  SectionIndex({Key key, this.account, this.project, this.projectSection}) : super(key: key);

  final Account account;
  final Project project;
  final ProjectSection projectSection;

  @override
  State<StatefulWidget> createState() => new _SectionIndexState();
}
