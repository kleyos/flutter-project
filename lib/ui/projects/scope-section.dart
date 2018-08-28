import 'package:flutter/material.dart';
import 'package:add_just/models/project-section.dart';
import 'package:add_just/ui/themes.dart';
import 'package:add_just/ui/projects/scope-section-item.dart';

class _ScopeSectionState extends State<ScopeSection> {

  List<Widget> _loadSectionItems() {
    return widget.scopeSection.scopeItems.map(
      (item) => ScopeSectionItem(sectionItem: item)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            color: Color.fromRGBO(224, 224, 224, 1.0),
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(top: 16.0),
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
    @required this.scopeSection
  }) : super(key: key);

  final ProjectSection scopeSection;

  @override
  State<StatefulWidget> createState() => new _ScopeSectionState();
}
