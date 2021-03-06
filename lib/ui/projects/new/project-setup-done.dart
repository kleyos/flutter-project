import 'package:add_just/ui/projects/projects-list.dart';
import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';
import 'package:flutter/material.dart';

class ProjectSetupDone extends StatelessWidget {
  void _handleNext(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ProjectsList())
    );
  }

  Widget _buildMainContent(BuildContext ctx) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Image(
          width: 150.0,
          height: 150.0,
          fit: BoxFit.cover,
          image: new AssetImage('assets/images/circular-check-button.png')
        ),
        new SizedBox(height: 32.0),
        new Text("Project setup is completed",
          style: Themes.pageHeader2, textAlign: TextAlign.center),
        new SizedBox(height: 32.0),
        new SingleActionButton(caption: 'GO TO PROJECTS LIST',
          onPressed: () { _handleNext(ctx); })
      ],
    );

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
            child: _buildMainContent(context)
          )
        ]
      )
    );
  }
}
