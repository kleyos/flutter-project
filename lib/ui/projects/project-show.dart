import 'package:flutter/material.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/services/project-permissions-resolver.dart';
import 'package:add_just/ui/chat/chat-view.dart';
import 'package:add_just/ui/projects/scope-show.dart';
import 'package:add_just/ui/projects/tabbed-app-bar.dart';
import 'package:add_just/ui/sections/boq-items-list.dart';

class _ProjectShowState extends State<ProjectShow> with SingleTickerProviderStateMixin{
  TabController controller;
  Project _project;
  bool _addBtnVisible = true;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final projectPool = new ProjectPool();

  void _loadProject() async {
    final p = await projectPool.getById(widget.projectId);
    setState(() {
      _project = p;
    });
  }
  
  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2, initialIndex: 0);
    controller.addListener(() {
      if (controller.indexIsChanging) {
        setState(() {
          _addBtnVisible = controller.index == 0;
        });
      }
    });
    _loadProject();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleMessageIconPress() {
    print('message count');
  }

  String _messageCount() {
    return '0';
  }
  
  Widget _iconBadge() {
    return new Container(
      width: 20.0,
      height: 20.0,
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.blueAccent,
      ),
      child: new Text(_messageCount(),
        style: TextStyle(fontWeight: FontWeight.bold)
      ),
    );
  }

  AppBar _projectTitleBuilder() {
    return _project != null
      ? new TabbedAppBar(
          projectName: _project.name,
          onMessagePress: () { _handleMessageIconPress(); },
          controller: controller,
          iconBadge: _iconBadge()
        )
      : new AppBar(title: new Text('...'));
  }

  VoidCallback _handleAddItemTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext c) => new BoqItemsList(
        projectId: widget.projectId
      )
    ));
  }

  Widget _buildAddScopeItemBtn() {
    if (_addBtnVisible && widget.permissionsResolver.canAddScopeItems) {
      return new FloatingActionButton(
        onPressed: _handleAddItemTap,
        tooltip: 'Add item',
        child: new Icon(Icons.add),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: _projectTitleBuilder(),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          _project != null ? ScopeShow(scaffoldKey: scaffoldKey, projectId: widget.projectId) : SizedBox(),
          ChatView(owner: 12),
        ]
      ),
      floatingActionButton: _buildAddScopeItemBtn()
    );
  }
}

class ProjectShow extends StatefulWidget {
  ProjectShow({
    Key key,
    @required this.projectId,
    @required this.permissionsResolver
  }) : super(key: key);

  final int projectId;
  final ProjectPermissionsResolver permissionsResolver;

  @override
  State<StatefulWidget> createState() => new _ProjectShowState();
}
