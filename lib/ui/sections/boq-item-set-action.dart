import 'package:flutter/material.dart';
import 'package:add_just/models/boq-items-container.dart';
import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';

typedef void OnBoqItemAdded(BoqItem item, num quantity);

class _BoqItemSetActionState extends State<BoqItemSetAction> {
  final _quantity = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _itemAdd(BuildContext context) {
    if (widget.onBoqItemAdded != null) {
      if (_formKey.currentState.validate()) {
        widget.onBoqItemAdded(widget.boqItem, num.parse(_quantity.text));
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
            new Text(widget.boqItem.name, style: Themes.boqItemTitle),
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
                  child: new Text(widget.boqItem.measure),
                ),
              ],
            ),
            new SizedBox(height: 24.0),
            new SingleActionButton(caption: '+ADD', onPressed: () { _itemAdd(context); })
          ]
        )
      )
    );
  }
}

class BoqItemSetAction extends StatefulWidget {
  BoqItemSetAction({
    Key key,
    this.boqItem,
    this.onBoqItemAdded
  }) : super(key: key);

  final BoqItem boqItem;
  final OnBoqItemAdded onBoqItemAdded;

  @override
  State<StatefulWidget> createState() => new _BoqItemSetActionState();
}