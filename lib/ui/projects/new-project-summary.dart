import 'package:add_just/services/api/base.dart';
import 'package:add_just/services/api/projects.dart';
import 'package:flutter/material.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/new-project.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';

class NewProjectSummary extends StatelessWidget {
  NewProjectSummary({Key key, this.account, this.project}) : super(key: key);

  final Account account;
  final NewProject project;
  
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
    print(project.toJson());
    try {
      Projects projectService = new Projects();
      String resp = await projectService.saveNewProject(account, project);
      print(resp);
    } catch (e) {
      print(e);
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
                      _buildSummaryRow('Project:', project.name),
                      _buildSummaryRow('Address:', project.address),
                      _buildSummaryRow('Area:', project.region.name),
                      _buildSummaryRow('Senior QS / Engineer:', project.user.displayName)
                    ],
                  )
                ),
                new SingleActionButton(caption: 'COMPLETE PROJECT SETUP', onPressed: _handleCompletePress)
              ],
            )
          )
        ]
      )
    );
  }
}
