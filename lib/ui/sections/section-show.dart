import 'package:add_just/models/account.dart';
import 'package:add_just/models/inline-project-section.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:flutter/material.dart';

class _SectionShowState extends State<SectionShow> {

  void _handleAddItem() {

  }

  Widget _buildSection() {
    return new Column(
      children: widget.inlineProjectSection.items.map((i) => new Text(i.name)).toList()
    );
  }

  Widget _buildMainContent() {
    return widget.project.sections.isEmpty
      ? new Center(child: new Text('Add the first item to this section'))
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
    @required this.inlineProjectSection
  }) : super(key: key);

  final Account account;
  final Project project;
  final InlineProjectSection inlineProjectSection;

  @override
  State<StatefulWidget> createState() => new _SectionShowState();
}
