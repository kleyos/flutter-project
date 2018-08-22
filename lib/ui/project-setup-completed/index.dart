import 'package:flutter/material.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/ui/project-setup-completed/navigation-with-tabs.dart';
import 'package:add_just/ui/project-setup-completed/chat.dart';
import 'package:add_just/ui/project-setup-completed/scope.dart';

class _ProjectSetupCompletedShowState extends State<ProjectSetupCompletedShow> with SingleTickerProviderStateMixin{
  
  TabController controller;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleMessageIconPress() {
    print('message count');
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
      child: new Text(widget.messageCount.toString(),
        style: TextStyle(fontWeight: FontWeight.bold)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: NavigationWithTabs(
        projectName: widget.project.name,
        onMessagePress: () { _handleMessageIconPress(); },
        controller: controller,
        iconBadge: _iconBadge()
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          Scope(scaffoldKey: scaffoldKey, currentProject: widget.project),
          Chat(owner: 12),
        ]
      )
    );
  }
}

class ProjectSetupCompletedShow extends StatefulWidget {
  ProjectSetupCompletedShow({Key key, this.project, this.messageCount}) : super(key: key);

  final Project project;
  final int messageCount;

  @override
  State<StatefulWidget> createState() => new _ProjectSetupCompletedShowState();
}


