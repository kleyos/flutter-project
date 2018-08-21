import 'package:flutter/material.dart';
import 'package:add_just/models/new-project.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/projects/new-project-finish.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/common.dart';

class _NewProjectSummaryState extends State<NewProjectSummary> {
  bool _isDataSending = false;
  final projectPool = new ProjectPool();

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
      Project p = await projectPool.saveNewProject(widget.newProject);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NewProjectFinish(
          projectId: p.id
        ))
      );
    } catch (e) {
      print(e.toString());
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
                      _buildSummaryRow('Project:', widget.newProject.name),
                      _buildSummaryRow('Address:', widget.newProject.address),
                      _buildSummaryRow('Area:', widget.newProject.region.name),
                      _buildSummaryRow('Senior QS / Engineer:', widget.newProject.user.displayName)
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
  NewProjectSummary({Key key, this.newProject}) : super(key: key);

  final NewProject newProject;

  @override
  State<StatefulWidget> createState() => new _NewProjectSummaryState();
}
