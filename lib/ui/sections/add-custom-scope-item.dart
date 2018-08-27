import 'package:add_just/ui/shared/single-action-button.dart';
import 'package:add_just/ui/themes.dart';
import 'package:flutter/material.dart';

typedef void OnCustomScopeItemAdded(String name, measure, num quantity);

class _AddCustomScopeItemState extends State<AddCustomScopeItem> {
  final _quantity = TextEditingController();
  final _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _measures = ['sqm', 'linm', 'cum', 'tonnes', 'kgs', 'nr', 'item', 'days', 'hours'];
  String _selectedMeasure = 'sqm';

  void _itemAdd() {
    if (widget.onCustomScopeItemAdded != null) {
      if (_formKey.currentState.validate()) {
        widget.onCustomScopeItemAdded(_name.text, _selectedMeasure, num.parse(_quantity.text));
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

  void changedDropDownItem(String selectedMeasure) {
    setState(() {
      _selectedMeasure = selectedMeasure;
    });
  }


  Widget _buildQuantityInput() {
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

  Widget _buildNameInput() {
    return new TextFormField(
      decoration: InputDecoration(
        labelText: 'Item Description',
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.all(8.0)
      ),
      autofocus: true,
//      validator:
      controller: _name
    );
  }

  Widget _buildMeasureSelector() {
    return new DropdownButton<String>(
      items: _measures.map((m) => new DropdownMenuItem<String>(
        value: m,
        child: new Text(m)
      )).toList(),
      onChanged: changedDropDownItem,
      value: _selectedMeasure,
    );
  }

  Widget _wrapInput(Widget input) {
    return new Container(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color.fromRGBO(229, 229, 229, 1.0)),
        borderRadius: BorderRadius.all(Radius.circular(4.0))
      ),
      child: input
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(24.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text('Add Custom Item', style: Themes.boqItemTitle),
                new SizedBox(height: 24.0),
                _wrapInput(_buildNameInput()),
                new SizedBox(height: 24.0),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 1,
                      child: _wrapInput(_buildQuantityInput())
                    ),
                    new SizedBox(width: 12.0),
                    _wrapInput(_buildMeasureSelector())
                  ],
                ),
                new SizedBox(height: 24.0),
                new SingleActionButton(caption: '+ADD', onPressed: _itemAdd)
              ]
            )
          )
        )
      ],
    );
  }
}

class AddCustomScopeItem extends StatefulWidget {
  AddCustomScopeItem({
    Key key,
    @required this.onCustomScopeItemAdded
  }) : super(key: key);

  final OnCustomScopeItemAdded onCustomScopeItemAdded;

  @override
  State<StatefulWidget> createState() => new _AddCustomScopeItemState();
}
