import 'package:flutter/material.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/models/account.dart';
import 'package:add_just/ui/chat/chat-navigation-bar.dart';
import './messages.dart' as messages;
import './scope.dart' as scope;

class _ProjectWithChatShowState extends State<ProjectWithChatShow> with SingleTickerProviderStateMixin{
  
  TabController controller;
  int _messageCount;
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
    return Container(
      width: 20.0,
      height: 20.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.blueAccent,
      ),
      child: Text('$_messageCount',
        style: TextStyle(fontWeight: FontWeight.bold)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: ChatNavigationBar(
        projectName: widget.project.name,
        onMessagePress: () { _handleMessageIconPress(); },
        controller: controller,
        iconBadge: _iconBadge()
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new scope.Scope(),
          new messages.Messages(owner: widget.account.id),
        ]
      )
    );
  }
}

class ProjectWithChatShow extends StatefulWidget {
  ProjectWithChatShow({Key key, this.account, this.project}) : super(key: key);

  final Account account;
  final Project project;

  @override
  State<StatefulWidget> createState() => new _ProjectWithChatShowState();
}