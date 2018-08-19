import 'package:flutter/material.dart';
import 'package:add_just/models/boq-items-container.dart';
import 'package:add_just/ui/shared/single-action-button.dart';

class BoqItemSet extends StatelessWidget {
  BoqItemSet({Key key, this.boqItem}) : super(key: key);

  final BoqItem boqItem;
  final TextEditingController _quantity = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(boqItem.name),
        new Row(
          children: <Widget>[
            new TextField(
              controller: _quantity
            ),
            new Text(boqItem.measure)
          ],
//          new SingleActionButton(caption: '+ADD')
        )
      ],
    );
  }
}