import 'package:flutter/material.dart';
import 'package:add_just/models/section-item.dart';
import 'package:add_just/ui/sections/section-item-amend.dart';
import 'package:add_just/ui/themes.dart';

typedef void OnSectionItemDeleted(SectionItem item);

class _SectionListItemState extends State<SectionListItem> {
  bool _isDeleted = false;

  bool get canAmend => true;
  bool get cannotIncrease => false;
  bool get cannotDecrease => false;

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
            onSectionItemAmended: widget.onSectionItemAmended,
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

  void _popupDeleteDialog(SectionItem item) {
    showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (context) => new AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
        content: new Container(
//          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: new Container(
            padding: EdgeInsets.all(32.0),
            child: new Text("Are you sure you want to remove '${item.name}'?",
              style: Themes.dialogText)
          )
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text('REMOVE'),
            onPressed: () {
              print('delete' + DateTime.now().toIso8601String());
              Navigator.of(context).pop();
              setState(() {
                _isDeleted = true;
              });
              if (widget.onSectionItemDeleted != null) {
                widget.onSectionItemDeleted(item);
              }
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

  Widget _buildMainContent() {
    return new InkWell(
      onTap: _tapHandler(),
      child: new Card(
        child: new Container(
          padding: const EdgeInsets.all(24.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new GestureDetector(
                child: new Container(
                  child: new Icon(Icons.delete, color: Colors.grey)
                ),
                onTap: () { _popupDeleteDialog(widget.sectionItem); },
              ),
              SizedBox(width: 6.0),
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

  @override
  Widget build(BuildContext context) {
    return new AnimatedCrossFade(
      duration: const Duration(milliseconds: 250),
      firstChild: new SizedBox(),
      secondChild: _buildMainContent(),
      crossFadeState: _isDeleted ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}

class SectionListItem extends StatefulWidget {
  SectionListItem({
    Key key,
    @required this.projectId,
    @required this.sectionItem,
    @required this.onSectionItemAmended,
    @required this.onSectionItemDeleted
  }) : super(key: key);

  final int projectId;
  final SectionItem sectionItem;
  final OnSectionItemAmended onSectionItemAmended;
  final OnSectionItemDeleted onSectionItemDeleted;

  @override
  State<StatefulWidget> createState() => new _SectionListItemState();
}
