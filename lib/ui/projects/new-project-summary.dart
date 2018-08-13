import 'package:flutter/material.dart';
import 'package:add_just/services/api/projects.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/new-project.dart';
import 'package:add_just/ui/projects/new-project-finish.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/common.dart';

class _NewProjectSummaryState extends State<NewProjectSummary> {
  bool _isDataSending = false;

  Function _submitPress() {
    return _isDataSending ? null : () { _handleCompletePress(); };
  }

  Widget _buildSummaryRow(String caption, text) {
    return new Row(
      children: <Widget>[
        new Text(caption, style: Themes.summaryCaption),
        const SizedBox(width: 6.0),
        new Text(text, style: Themes.summaryData)
      ],
    );
  }

  void _handleCompletePress() async {
    try {
      setState(() {
        _isDataSending = true;
      });
      Projects projectService = new Projects();
      await projectService.saveNewProject(widget.account, widget.project);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NewProjectFinish(
          account: widget.account,
          project: widget.project
        ))
      );
    } catch (e) {
      print(e);
      showAlert(context, e.toString());
    } finally {
      setState(() {
        _isDataSending = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: AddJustTitle(),
        centerTitle: true
      ),
      body: new Stack(
        children: <Widget>[
          new BackgroundImage(),
          new Container(
            padding: const EdgeInsets.all(42.0),
            child: new Column(
              children: <Widget>[
                new Text('Review', style: Themes.pageHeader2),
                new Text('Please review details entered and complete project setup to add the project to projects list. ',
                  style: Themes.pageHeaderHint, textAlign: TextAlign.center),
                const SizedBox(height: 16.0),
                new Expanded(
                  flex: 1,
                  child: new Column(
                    children: <Widget>[
                      _buildSummaryRow('Project:', widget.project.name),
                      _buildSummaryRow('Address:', widget.project.address),
                      _buildSummaryRow('Area:', widget.project.region.name),
                      _buildSummaryRow('Senior QS / Engineer:', widget.project.user.displayName)
                    ],
                  )
                ),
                new SingleActionButton(caption: 'COMPLETE PROJECT SETUP', onPressed: _submitPress())
              ],
            )
          )
        ]
      )
    );
  }
}

class NewProjectSummary extends StatefulWidget {
  NewProjectSummary({Key key, this.account, this.project}) : super(key: key);

  final Account account;
  final NewProject project;

  @override
  State<StatefulWidget> createState() => new _NewProjectSummaryState();
}
