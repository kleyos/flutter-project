import 'package:flutter/material.dart';
import 'package:add_just/models/section-item.dart';
import 'package:add_just/ui/themes.dart';

class _SectionListItemState extends State<SectionListItem> {

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
        padding: const EdgeInsets.all(24.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: new Text(widget.sectionItem.name, style: Themes.sectionItemTitle)
            ),
            new Text(widget.sectionItem.quantity.toString(), style: Themes.sectionItemTitle),
            new Text(widget.sectionItem.measure, style: Themes.sectionItemTitle),
          ],
        ),
      )
    );
  }
}

class SectionListItem extends StatefulWidget {
  SectionListItem({Key key, @required this.sectionItem}) : super(key: key);

  final SectionItem sectionItem;

  @override
  State<StatefulWidget> createState() => new _SectionListItemState();
}
