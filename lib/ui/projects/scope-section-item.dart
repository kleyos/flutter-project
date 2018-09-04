import 'package:flutter/material.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/section-item.dart';
import 'package:add_just/services/project-permissions-resolver.dart';
import 'package:add_just/ui/sections/section-item-amend.dart';
import 'package:add_just/ui/themes.dart';

typedef void OnSectionItemDeleted(SectionItem item);

class _ScopeSectionItemState extends State<ScopeSectionItem> {
  bool _isDeleted = false;

  bool get cannotIncrease => !widget.permissionsResolver.canIncScopeItemQty;
  bool get cannotDecrease => !widget.permissionsResolver.canDecScopeItemQty;
  bool get canAmend => !cannotIncrease || !cannotDecrease;

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
              if (widget.onSectionItemDeleted != null) {
                widget.onSectionItemDeleted(item);
              }
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

  Widget _buildRemoveControl() {
    return new GestureDetector(
      child: new Container(
        child: new Icon(Icons.delete, color: Colors.grey)
      ),
      onTap: () { _popupDeleteDialog(widget.sectionItem); },
    );
  }

  Widget _composeCardContent() {
    if (Account.current.isAMO) {
      return _composeAMOCardContent();
    }

    if (Account.current.isContractor) {
      return _composeCTRCardContent();
    }

    return new SizedBox();
  }

  Widget _composeAMOCardContent() {
    List<Widget> items = [];
    if (widget.permissionsResolver.canRemoveScopeItems) {
      items.add(_buildRemoveControl());
      items.add(SizedBox(width: 6.0));
    }

    if (widget.permissionsResolver.canSetDoneScopeItems) {
      items.add(new Checkbox(value: widget.sectionItem.completed, onChanged: (val) {
        print(val);
      }));
      items.add(SizedBox(width: 6.0));
    }

    items.add(new Expanded(child: new Text(widget.sectionItem.name, style: Themes.sectionItemTitle)));
    items.add(new SizedBox(width: 6.0));
    items.add(new Text(widget.sectionItem.quantity.toString(), style: Themes.sectionItemTitle));
    items.add(new SizedBox(width: 6.0));
    items.add(new Text(widget.sectionItem.measure, style: Themes.sectionItemTitle));

    Row row = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: items
    );

    Column col = new Column(
      children: <Widget>[
        row,
        widget.sectionItem.deductedQuantity != null
          ? new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Text("Change  -${widget.sectionItem.deductedQuantity} ${widget.sectionItem.measure}",
                style: Themes.scopeItemSmallMeasure)
            ],
          )
          : const SizedBox()
      ],
    );

    return col;
  }

  Widget _composeCTRCardContent() {
    return new Column(
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Text('TOTAL', textAlign: TextAlign.right, style: Themes.scopeItemPriceTotalCaption)
          ],
        ),
        new Row(
          children: <Widget>[
            new Expanded(child: new Text(widget.sectionItem.name, style: Themes.sectionItemTitle)),
            new Text('${widget.sectionItem.quantity}${widget.sectionItem.measure}',
              style: Themes.scopeItemSmallMeasure),
            SizedBox(width: 6.0),
            new Text('${widget.sectionItem.currency}${widget.sectionItem.price}',
              style: Themes.scopeItemPrice),
            SizedBox(width: 12.0),
            new Text('${widget.sectionItem.currency}${widget.sectionItem.quantity * widget.sectionItem.price}',
              style: Themes.sectionItemTitle)
          ],
        )
      ],
    );
  }

  EdgeInsetsGeometry _cardPadding() {
    if (Account.current.isContractor) {
      return const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 24.0);
    }
    return const EdgeInsets.all(24.0);
  }

  Widget _buildMainContent() {
    return new InkWell(
      onTap: _tapHandler(),
      child: new Card(
        child: new Container(
          padding: _cardPadding(),
          child: _composeCardContent(),
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

class ScopeSectionItem extends StatefulWidget {
  ScopeSectionItem({
    Key key,
    @required this.projectId,
    @required this.sectionItem,
    @required this.onSectionItemAmended,
    @required this.onSectionItemDeleted,
    @required this.permissionsResolver
  }) : super(key: key);

  final int projectId;
  final SectionItem sectionItem;
  final OnSectionItemAmended onSectionItemAmended;
  final OnSectionItemDeleted onSectionItemDeleted;
  final ProjectPermissionsResolver permissionsResolver;

  @override
  State<StatefulWidget> createState() => new _ScopeSectionItemState();
}
