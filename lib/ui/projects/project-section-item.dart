import 'package:flutter/material.dart';
import 'package:add_just/models/project-section.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/sections/section-show.dart';
import 'package:add_just/ui/themes.dart';

class _ProjectSectionItemState extends State<ProjectSectionItem> {
  final projectPool = new ProjectPool();

  void _handleProjectTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => new SectionShow(
      projectId: widget.projectId,
      projectSectionId: widget.projectSectionId
    )));
  }

  Widget _buildMainContent(BuildContext ctx, AsyncSnapshot<Project> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return new SizedBox();
    }
    ProjectSection projectSection = snapshot.data.sectionById(widget.projectSectionId);
    return new InkWell(
      onTap: () { _handleProjectTap(context); },
      child: new Container(
        color: Color.fromRGBO(224, 224, 224, 1.0),
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.only(top: 16.0),
        child: new Row(
          children: <Widget>[
            Text(projectSection.name.toUpperCase(), style: Themes.projectSectionTitle),
            new SizedBox(width: 12.0),
            Text(projectSection.itemsCount.toString(), style: Themes.projectSectionNum),
            new Expanded(child: new SizedBox()),
            new Icon(Icons.chevron_right)
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: projectPool.getById(widget.projectId),
      builder: _buildMainContent
    );
  }
}

class ProjectSectionItem extends StatefulWidget {
  ProjectSectionItem({
    Key key,
    @required this.projectId,
    @required this.projectSectionId
  }) : super(key: key);

  final int projectId, projectSectionId;

  @override
  State<StatefulWidget> createState() => new _ProjectSectionItemState();
}
