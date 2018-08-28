import 'package:flutter/material.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/services/api/project-pool.dart';
import 'package:add_just/ui/chat/chat-view.dart';
import 'package:add_just/ui/projects/scope-show.dart';
import 'package:add_just/ui/projects/tabbed-app-bar.dart';

class _ProjectShowState extends State<ProjectShow> with SingleTickerProviderStateMixin{
  TabController controller;
  Project _project;
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
      )
    );
  }
}

class ProjectShow extends StatefulWidget {
  ProjectShow({Key key, this.projectId}) : super(key: key);

  final int projectId;

  @override
  State<StatefulWidget> createState() => new _ProjectShowState();
}
