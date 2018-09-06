import 'package:add_just/ui/projects/projects-list.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:flutter/material.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/shared/background-image.dart';

class CompletedScreen extends StatelessWidget {

  CompletedScreen({
    Key key,
    @required this.screenText,
  }) : super(key: key);

  final String screenText;

  void _handleGoToProgectsList(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ProjectsList())
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return new Stack(
      children: <Widget>[
        new BackgroundImage(),
        new Container(
          padding: const EdgeInsets.all(42.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                child: new Column(
                  children: <Widget>[
                    new SizedBox(height: 32.0),
                    new Image(
                      width: 150.0,
                      height: 150.0,
                      fit: BoxFit.cover,
                      image: new AssetImage('assets/images/circular-check-button.png')
                    ),
                    new SizedBox(height: 42.0),
                    new Text(screenText,
                      style: Themes.pageHeader2, textAlign: TextAlign.center),
                  ]
                )
              ),
              new SingleActionButton(caption: 'GO TO PROJECTS LIST',
                onPressed: () { _handleGoToProgectsList(ctx); }),
            ],
          )
        )
      ]
    );
  }
}
