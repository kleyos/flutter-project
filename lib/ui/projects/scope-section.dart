import 'package:flutter/material.dart';
import 'package:add_just/models/project-section.dart';
import 'package:add_just/models/section-item.dart';
import 'package:add_just/services/project-permissions-resolver.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/projects/scope-section-item.dart';

class _ScopeSectionState extends State<ScopeSection> {
  final projectPool = new ProjectPool();

  Widget _buildScopeSectionItem(SectionItem item) {
    return new ScopeSectionItem(
      projectId: widget.projectId,
      sectionItem: item,
      onSectionItemAmended: (item, quantity) async{
        await projectPool.setScopeItemQuantity(widget.projectId, item.id, quantity);
        _showAtSnackBar("Quantity of '${item.name}' set to ${item.quantity}");
      },
      onSectionItemDeleted: (item) async {
        await projectPool.removeScopeItem(widget.projectId, item.id);
        _showAtSnackBar("'${item.name}' removed!");
      },
      permissionsResolver: widget.permissionsResolver
    );
  }

  List<Widget> _loadSectionItems() {
    return widget.scopeSection.scopeItems.map((item) => _buildScopeSectionItem(item)).toList();
  }

  void _showAtSnackBar(String text) {
    widget.scaffoldKey.currentState.showSnackBar(
      new SnackBar(content: new Text(text))
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            color: Themes.scopeSectionBackgroundColor,
            padding: EdgeInsets.fromLTRB(30.0, 12.0, 12.0, 12.0),
            child: new Row(
              children: <Widget>[
                new Text(widget.scopeSection.name.toUpperCase(),
                  style: Themes.projectSectionTitle)
              ]
            )
          ),
          new Container(
            padding: EdgeInsets.all(12.0),
            child: new Column(
              children: _loadSectionItems(),
            )
          )
        ]
      )
    );
  }
}

class ScopeSection extends StatefulWidget {
  ScopeSection({
    Key key,
    @required this.projectId,
    @required this.scopeSection,
    @required this.permissionsResolver,
    @required this.scaffoldKey
  }) : super(key: key);

  final int projectId;
  final ProjectSection scopeSection;
  final ProjectPermissionsResolver permissionsResolver;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<StatefulWidget> createState() => new _ScopeSectionState();
}
