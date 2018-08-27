import 'package:flutter/material.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/sections/add-custom-scope-item.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/themes.dart';

class _AddCustomScopeItemActionState extends State<AddCustomScopeItemAction> {
  final projectPool = new ProjectPool();

  void _handleCustomScopeItemAdded(String name, measure, num quantity) async {
    try {
      await projectPool.addCustomScopeItem(
        widget.projectId, widget.sectionId, quantity, name, measure);
    } catch (e) {
      showAlert(context, e.toString());
    }
  }

  void _handleTap() {
    showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (context) => new AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
        content: new Container(
//          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: new AddCustomScopeItem(onCustomScopeItemAdded: _handleCustomScopeItemAdded)
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

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () { _handleTap(); },
      child: new Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.all(16.0),
          child: new Row(
            children: <Widget>[
              Text('Add Custom Item', style: Themes.popupDialogAction),
            ]
          ),
        ),
        new Divider()
      ]
    )
    );
  }
}

class AddCustomScopeItemAction extends StatefulWidget {
  AddCustomScopeItemAction({
    Key key,
    @required this.projectId,
    @required this.sectionId
  }) : super(key: key);

  final int projectId, sectionId;

  @override
  State<StatefulWidget> createState() => new _AddCustomScopeItemActionState();
}
