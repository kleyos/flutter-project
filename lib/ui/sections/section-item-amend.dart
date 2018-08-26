import 'package:add_just/models/section-item.dart';
import 'package:flutter/material.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';

typedef void OnSectionItemUpdated(SectionItem item, num amount);

class _SectionItemAmendState extends State<SectionItemAmend> {
  final _quantity = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _quantity.text = widget.sectionItem.quantity.toString();
    super.initState();
  }

  void _itemAmend(BuildContext context) {
    if (widget.onSectionItemUpdated != null) {
      if (_formKey.currentState.validate()) {
        final v = num.parse(_quantity.text);
        if (widget.sectionItem.quantity != v) {
          widget.onSectionItemUpdated(widget.sectionItem, v);
        }
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
    }
  }

  String numberValidator(String value) {
    if (value == null) {
      return null;
    }
    try {
      final v = num.parse(value);
      if (v == null) {
        return '"$value" is not a valid number';
      }
      if (widget.cannotIncrease && widget.sectionItem.quantity < v) {
        return 'Cannot increase quantity!';
      }
      if (widget.cannotDecrease && widget.sectionItem.quantity > v) {
        return 'Cannot decrease quantity!';
      }
    } catch (e){
      return '"$value" is not a valid number';
    }
    return null;
  }

  Widget _buildInput() {
    return new TextFormField(
      decoration: InputDecoration(
        labelText: 'Quantity',
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.all(8.0)
      ),
      autofocus: true,
      keyboardType: TextInputType.number,
      validator: numberValidator,
      controller: _quantity
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(24.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(widget.sectionItem.name, style: Themes.boqItemTitle),
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
                    child: _buildInput()
                  )
                ),
                new SizedBox(width: 12.0),
                new Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Color.fromRGBO(229, 229, 229, 1.0)),
                    borderRadius: BorderRadius.all(Radius.circular(4.0))
                  ),
                  child: new Text(widget.sectionItem.measure),
                ),
              ],
            ),
            new SizedBox(height: 24.0),
            new SingleActionButton(caption: 'CHANGE', onPressed: () { _itemAmend(context); })
          ]
        )
      )
    );
  }
}

class SectionItemAmend extends StatefulWidget {
  SectionItemAmend({
    Key key,
    @required this.sectionItem,
    @required this.onSectionItemUpdated,
    @required this.cannotIncrease,
    @required this.cannotDecrease
  }) : super(key: key);

  final SectionItem sectionItem;
  final OnSectionItemUpdated onSectionItemUpdated;
  final bool cannotIncrease, cannotDecrease;

  @override
  State<StatefulWidget> createState() => new _SectionItemAmendState();
}
