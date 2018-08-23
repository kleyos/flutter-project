import 'package:add_just/ui/sections/section-item-amend.dart';
import 'package:flutter/material.dart';
import 'package:add_just/models/section-item.dart';
import 'package:add_just/ui/themes.dart';

class _SectionListItemState extends State<SectionListItem> {

  bool get canAmend => true;
  bool get cannotIncrease => false;
  bool get cannotDecrease => false;

  void onSectionItemUpdated(SectionItem item, num amount) {
    print(amount);
  }

  void _popupAmendDialog() {
    showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (context) => new AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
        content: new Container(
//          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: new SectionItemAmend(
            sectionItem: widget.sectionItem,
            onSectionItemUpdated: onSectionItemUpdated,
            cannotIncrease: cannotIncrease,
            cannotDecrease: cannotDecrease
          )
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      )
    );
  }

  Function _tapHandler() {
    return canAmend
      ? () { _popupAmendDialog(); }
      : null;
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: _tapHandler(),
      child: new Card(
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
              SizedBox(width: 6.0),
              new Text(widget.sectionItem.measure, style: Themes.sectionItemTitle),
            ],
          ),
        )
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
