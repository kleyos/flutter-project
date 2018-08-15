import 'package:flutter/material.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/ui/themes.dart';

typedef void OnSelectedItemsChanges(List<String> items);

class _SectionsListState extends State<SectionsList> {
  List<String> _selectedSections = [];

  Widget _buildAddButton() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new FlatButton(
          onPressed: null,
          child: new Text('Add new', textAlign: TextAlign.left, style: Themes.popupDialogAction)
        ),
        new Divider()
      ],
    );
  }

  Widget _buildCheckbox(String title) {
    return new Column(
      children: <Widget>[
        new CheckboxListTile(
          title: new Text(title),
          value: _selectedSections.contains(title),
          onChanged: (bool value) {
            setState(() {
              _selectedSections.contains(title)
                ? _selectedSections.remove(title)
                : _selectedSections.add(title);
            });
            if (widget.onSelectedItemsChanges != null) {
              widget.onSelectedItemsChanges(_selectedSections);
            }
          }
        ),
        new Divider()
      ]
    );
  }

  Widget _buildCheckboxes() {
    List<Widget> items = List.from(widget.sections).map((l) => _buildCheckbox(l)).toList();
    items.add(_buildAddButton());

    return new Expanded(
      flex: 1,
      child: new ListView(
        shrinkWrap: true,
        children: items
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sections != null) {
      return new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCheckboxes()
        ]
      );
    } else {
      return new Center(child: CircularProgressIndicator());
    }
  }
}

class SectionsList extends StatefulWidget {
  SectionsList({Key key, this.account, this.sections, this.onSelectedItemsChanges}) : super(key: key);

  final Account account;
  final List<String> sections;
  final OnSelectedItemsChanges onSelectedItemsChanges;

  @override
  State<StatefulWidget> createState() => new _SectionsListState();
}
