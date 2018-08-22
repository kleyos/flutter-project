import 'package:flutter/material.dart';
import 'package:add_just/models/section-item.dart';
import 'package:add_just/ui/themes.dart';

class _ScopeSectionItemState extends State<ScopeSectionItem> {
  bool _isChanged = false;

  Widget _buildLid() {
    return new Container(
      width: 10.0,
      height: 10.0,
      decoration: new BoxDecoration(
        color: Color.fromRGBO(15, 111, 230, 1.0),
        shape: BoxShape.circle,
      ),
    );
  }

  void _itemPress() {
    setState(() {
      _isChanged = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: new Container(
        padding: widget.sectionItem.completed
          ? EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 15.0)
          : EdgeInsets.all(20.0),
        child: new InkWell(
          onTap: () { _itemPress(); },
          child: new Column(
            children: <Widget>[
              _isChanged
                ? new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _buildLid()
                    ],
                  )
                : new SizedBox(),
              new Row(
                children: <Widget>[
                  widget.sectionItem.completed
                    ? new Checkbox(
                        value: true,
                        onChanged: (_) {},
                      )
                    : new SizedBox(),
                  new Flexible(
                    child: new Text(widget.sectionItem.name, style: Themes.scopeSectionItemName)
                  ),
                  new Expanded(
                    child: new SizedBox()
                  ),
                  new Text(widget.sectionItem.quantity.toString(), style: Themes.scopeSectionItemName),
                  new Text(widget.sectionItem.measure, style: Themes.scopeSectionItemName)
                ],
              ),
              _isChanged
                ? new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text("Change")
                    ],
                  )
                : new SizedBox(),
            ],
          )
        )
      )
    );
  }
}

class ScopeSectionItem extends StatefulWidget {
  ScopeSectionItem({
    Key key,
    @required this.sectionItem,
  }) : super(key: key);

  final SectionItem sectionItem;

  @override
  State<StatefulWidget> createState() => new _ScopeSectionItemState();
}
