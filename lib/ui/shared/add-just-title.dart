import 'package:flutter/material.dart';
import 'package:add_just/ui/themes.dart';

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
        new Text('+Add', style: Themes.mainTitleLight),
        new Text('Just', style: Themes.mainTitleBold),
        new SizedBox(width: 48.0)
      ],
    );
  }
}