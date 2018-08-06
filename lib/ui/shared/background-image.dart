import 'package:flutter/material.dart';

class BackgroundImage extends Container {
  BackgroundImage({
    Key key
  }) : super(key: key, decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage("assets/images/background.png"),
        fit: BoxFit.cover
      ),
    )
  );
}
