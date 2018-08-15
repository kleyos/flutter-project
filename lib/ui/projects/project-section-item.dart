import 'package:add_just/models/project-section.dart';
import 'package:add_just/ui/themes.dart';
import 'package:flutter/material.dart';

class _ProjectSectionItemState extends State<ProjectSectionItem> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color.fromRGBO(224, 224, 224, 1.0),
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(top: 16.0),
      child: new Row(
        children: <Widget>[
          Text(widget.projectSection.name.toUpperCase(), style: Themes.projectSectionTitle),
          new SizedBox(width: 12.0),
          Text(widget.projectSection.numItems.toString(), style: Themes.projectSectionNum)
        ],
      ),
    );
  }
}

class ProjectSectionItem extends StatefulWidget {
  ProjectSectionItem({Key key, this.projectSection}) : super(key: key);

  final ProjectSection projectSection;

  @override
  State<StatefulWidget> createState() => new _ProjectSectionItemState();
}
