import 'package:flutter/material.dart';

void showAlert(BuildContext context, String msg) {
  showDialog<Null>(
    context: context,
    barrierDismissible: false,
    builder: (context) => new AlertDialog(
      title: new Text("Alert"),
      content: new Text(msg),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    )
  );
}
