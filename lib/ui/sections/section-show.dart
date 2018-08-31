import 'package:flutter/material.dart';
import 'package:add_just/models/section-item.dart';
import 'package:add_just/models/project-section.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/project-permissions-resolver.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/projects/scope-section-item.dart';
import 'package:add_just/ui/sections/boq-items-list.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/common.dart';
import 'package:add_just/ui/themes.dart';

class _SectionShowState extends State<SectionShow> {
  final _scaffoldKey =  new GlobalKey<ScaffoldState>();
  final projectPool = new ProjectPool();

  void _handleAmendItem(SectionItem item, num quantity) async {
    try {
      await projectPool.setScopeItemQuantity(widget.projectId, item.id, quantity);
      _showAtSnackBar("Quantity of '${item.name}' set to ${item.quantity}");
    } catch (e) {
      showAlert(context, e.toString());
    }
  }

  void _handleDeleteItem(SectionItem item) async {
    await projectPool.removeScopeItem(widget.projectId, item.id);
    _showAtSnackBar("'${item.name}' removed from this section");
  }

  void _showAtSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(content: new Text(text))
    );
  }

  void _handleAddItem() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext c) => new BoqItemsList(
        projectId: widget.projectId, projectSectionId: widget.projectSectionId
      )
    ));
  }

  Widget _buildSectionItem(SectionItem item) {
    return new ScopeSectionItem(
      projectId: widget.projectId,
      sectionItem: item,
      onSectionItemAmended: _handleAmendItem,
      onSectionItemDeleted: _handleDeleteItem,
      permissionsResolver: widget.permissionsResolver
    );
  }

  Widget _buildSectionHeader(String text) {
    return new Container(
      padding: EdgeInsets.all(16.0),
      color: new Color.fromRGBO(224, 224, 224, 1.0),
      child: new Row(
        children: <Widget>[
          new Text(text.toUpperCase(), style: Themes.projectSectionTitle)
        ]
      )
    );
  }

  Widget _buildSection(BuildContext ctx, AsyncSnapshot<Project> sn) {
    if (sn.connectionState != ConnectionState.done) {
      return new SizedBox();
    }
    ProjectSection section = sn.data.sectionById(widget.projectSectionId);
    return new Column(
      children: <Widget>[
        _buildSectionHeader(section.name),
        new Container(
          padding: EdgeInsets.all(16.0),
          child: new Column(
            children: section.scopeItems.map((i) => _buildSectionItem(i)).toList(),
          )
        )
      ]
    );
  }


  Widget _buildTitle(BuildContext ctx, AsyncSnapshot<Project> sn) {
    if (sn.connectionState != ConnectionState.done) {
      return new SizedBox();
    }
    return new Text(sn.data.name);
  }

  Widget _buildMainContent() {
    return widget.projectSectionId == null
      ? new Center(
        child: new Text('Add the first item to this section',
          style: Themes.pageHeader2, textAlign: TextAlign.center)
        )
      : new ListView(
        shrinkWrap: true,
        children: <Widget>[
          new FutureBuilder(
            future: projectPool.getById(widget.projectId),
            builder: _buildSection
          )
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new FutureBuilder(
          future: projectPool.getById(widget.projectId),
          builder: _buildTitle,
        ),
        centerTitle: true
      ),
      body: new Stack(
        children: <Widget>[
          new BackgroundImage(),
          new Container(
            child: _buildMainContent()
          )
        ]
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () { _handleAddItem(); },
        tooltip: 'Add item',
        child: new Icon(Icons.add),
      )
    );
  }
}

class SectionShow extends StatefulWidget {
  SectionShow({
    Key key,
    @required this.projectId,
    @required this.projectSectionId,
    @required this.permissionsResolver
  }) : super(key: key);

  final int projectId, projectSectionId;
  final ProjectPermissionsResolver permissionsResolver;


  @override
  State<StatefulWidget> createState() => new _SectionShowState();
}
