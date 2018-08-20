import 'package:add_just/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:add_just/models/boq-items-container.dart';
import 'package:add_just/ui/shared/single-action-button.dart';

typedef void OnBoqItemAdded(BoqItem item);

class BoqItemSet extends StatelessWidget {
  BoqItemSet({Key key, this.boqItem, this.onBoqItemAdded}) : super(key: key);

  final BoqItem boqItem;
  final TextEditingController _quantity = TextEditingController();
  final OnBoqItemAdded onBoqItemAdded;

  void _itemAdd(BuildContext context) {
    if (onBoqItemAdded != null) {
      onBoqItemAdded(boqItem);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(24.0),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(boqItem.name, style: Themes.boqItemTitle),
          new SizedBox(height: 24.0),
          new Row(
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new Container(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Color.fromRGBO(229, 229, 229, 1.0)),
                    borderRadius: BorderRadius.all(Radius.circular(4.0))
                  ),
                  child: new TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.all(8.0)
                    ),
                    controller: _quantity
                  )
                )
              ),
              new SizedBox(width: 12.0),
              new Container(
                padding: const EdgeInsets.all(16.0),
                decoration: new BoxDecoration(
                  border: new Border.all(color: Color.fromRGBO(229, 229, 229, 1.0)),
                  borderRadius: BorderRadius.all(Radius.circular(4.0))
                ),
                child: new Text(boqItem.measure),
              ),
            ],
          ),
          new SizedBox(height: 24.0),
          new SingleActionButton(caption: '+ADD', onPressed: () { _itemAdd(context); })
        ]
      )
    );
  }
}