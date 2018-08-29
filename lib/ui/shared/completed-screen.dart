import 'package:flutter/material.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/shared/background-image.dart';

class CompletedScreen extends StatelessWidget {

  CompletedScreen({
    Key key,
    @required this.screenText,
  }) : super(key: key);

  final String screenText;

  @override
  Widget build(BuildContext context) {
    return new Stack(
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
              new Text(screenText, style: Themes.pageHeader2, textAlign: TextAlign.center),
              new SizedBox(height: 32.0),
            ],
          )
        )
      ]
    );
  }
}
