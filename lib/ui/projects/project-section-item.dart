import 'package:add_just/models/account.dart';
import 'package:add_just/models/project-section.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/ui/sections/section-show.dart';
import 'package:add_just/ui/themes.dart';
import 'package:flutter/material.dart';

class _ProjectSectionItemState extends State<ProjectSectionItem> {
  void _handleProjectTap(BuildContext context) {
    print(widget.account);
    print(widget.projectSection);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => new SectionShow(
      account: widget.account,
      project: widget.project,
      projectSection: widget.project.sectionByName(widget.projectSection.name)
    )));
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () { _handleProjectTap(context); },
      child: new Container(
        color: Color.fromRGBO(224, 224, 224, 1.0),
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.only(top: 16.0),
        child: new Row(
          children: <Widget>[
            Text(widget.projectSection.name.toUpperCase(), style: Themes.projectSectionTitle),
            new SizedBox(width: 12.0),
            Text(widget.projectSection.itemsCount.toString(), style: Themes.projectSectionNum),
            new Expanded(child: new SizedBox()),
            new Icon(Icons.chevron_right)
          ],
        ),
      )
    );
  }
}

class ProjectSectionItem extends StatefulWidget {
  ProjectSectionItem({
    Key key,
    @required this.account,
    @required this.project,
    @required this.projectSection
  }) : super(key: key);

  final ProjectSection projectSection;
  final Account account;
  final Project project;

  @override
  State<StatefulWidget> createState() => new _ProjectSectionItemState();
}
