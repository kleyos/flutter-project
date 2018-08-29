import 'package:flutter/material.dart';
import 'package:add_just/models/project-section.dart';
import 'package:add_just/services/project-permissions-resolver.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/projects/scope-section-item.dart';

class _ScopeSectionState extends State<ScopeSection> {

  List<Widget> _loadSectionItems() {
    return widget.scopeSection.scopeItems.map((item) => ScopeSectionItem(
      projectId: widget.projectId,
      sectionItem: item,
      onSectionItemAmended: (_, __) {},
      onSectionItemDeleted: (_) {},
      permissionsResolver: widget.permissionsResolver
    )).toList();
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
            margin: EdgeInsets.only(top: 12.0),
            child: new Row(
              children: <Widget>[
                new Text(widget.scopeSection.name.toUpperCase(),
                  style: Themes.projectSectionTitle)
              ]
            )
          ),
          new Column(
            children: _loadSectionItems(),
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
    @required this.permissionsResolver
  }) : super(key: key);

  final int projectId;
  final ProjectSection scopeSection;
  final ProjectPermissionsResolver permissionsResolver;

  @override
  State<StatefulWidget> createState() => new _ScopeSectionState();
}
