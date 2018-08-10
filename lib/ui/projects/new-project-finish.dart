import 'package:add_just/ui/shared/add-just-title.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:add_just/models/new-project.dart';

class NewProjectFinish extends StatelessWidget {
  NewProjectFinish({Key key, this.project}) : super(key: key);

  final NewProject project;

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Image(
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                  image: new AssetImage('assets/images/circular-check-button.png')
                ),
                new SizedBox(height: 32.0),
                new Text("${project.name} has been added to project list",
                  style: Themes.pageHeader2, textAlign: TextAlign.center)
              ],
            )
          )
        ]
      )
    );
  }
}
