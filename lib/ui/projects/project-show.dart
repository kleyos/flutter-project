import 'package:flutter/material.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/themes.dart';

class _ProjectShowState extends State<ProjectShow> {
  final List<String> _sections = ['Kitchen', 'Living Room', 'Bathroom'];

  Widget _buildOpts() {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new ListView.separated(
          itemBuilder: (context, idx) =>
            new CheckboxListTile(
              title: new Text(_sections[idx]),
              value: false,
              onChanged: (bool value) {
              //                  setState(() { timeDilation = value ? 20.0 : 1.0; });
              }
            ),
          separatorBuilder: (context, _) => new Divider(),
          itemCount: _sections.length,
          shrinkWrap: true
        ),
        new Divider(),
        new FlatButton(
          onPressed: null,
          child: new Text('Add new', textAlign: TextAlign.left, style: Themes.popupDialogAction)
        ),
        new Divider()
      ],
    );
  }
  
  void _handleAddSections() {
    showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (context) => new AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
        content: new Container(
//          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _buildOpts()
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('SAVE'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      )
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
          new Container(
            padding: const EdgeInsets.all(42.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('Start creating your scope of works by adding your first section below.',
                  style: Themes.pageHeader2, textAlign: TextAlign.center),
              ],
            )
          )
        ]
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () { _handleAddSections(); },
        tooltip: 'Add sections',
        child: new Icon(Icons.add),
      )
    );
  }
}

class ProjectShow extends StatefulWidget {
  ProjectShow({Key key, this.account, this.project}) : super(key: key);

  final Account account;
  final Project project;

  @override
  State<StatefulWidget> createState() => new _ProjectShowState();
}
