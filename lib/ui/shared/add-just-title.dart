import 'package:flutter/material.dart';

class AddJustTitle extends StatelessWidget {
  AddJustTitle({
    Key key,
    this.fontSize
  }) : super(key: key);

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text('+Add', style: TextStyle(fontSize: fontSize ?? 30.0)),
        new Text('Just', style: TextStyle(fontSize: fontSize ?? 30.0, fontWeight: FontWeight.bold))
      ],
    );
  }
}