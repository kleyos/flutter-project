import 'package:flutter/material.dart';
import 'package:add_just/ui/themes.dart';

class SingleActionButton extends SizedBox {
  SingleActionButton({
    Key key,
    this.caption,
    this.onPressed
  }) : super(key: key, width: double.infinity, child: new RaisedButton(
    onPressed: onPressed,
    child: new Text(caption, style: Themes.buttonCaption),
    color: Colors.teal
  ));

  final VoidCallback onPressed;
  final String caption;
}
