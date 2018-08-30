import 'package:flutter/material.dart';

class TabbedAppBar extends AppBar {

  TabbedAppBar({
    Key key,
    this.messageCount,
    this.iconBadge,
    this.onPersonPress,
    @required this.projectName,
    @required this.onMessagePress,
    @required this.controller,
    @required this.userRole,
  }) : super(
    key: key,
    leading: new BackButton(),
    title: new Text(projectName),
    centerTitle: true,
    actions: <Widget>[
      new IconButton(
        icon: new Stack(
          overflow: Overflow.visible,
          children: [
            new Icon(Icons.message),
            new Positioned(
              top: -5.0,
              left: 13.0,
              child: messageCount != null
                ? iconBadge(messageCount)
                : new SizedBox()
            )
          ],
        ),
        onPressed: onMessagePress
      ),
      userRole == 'ctr'
        ? new IconButton(
        icon: new Icon(Icons.person_add),
        onPressed: onPersonPress
      )
        : new SizedBox(width: 25.0)
    ],
    bottom: new PreferredSize(
      preferredSize: const Size.fromHeight(48.0),
      child: new TabBar(
        controller: controller,
        tabs: <Tab>[
          new Tab(text: 'SCOPE'),
          new Tab(text: 'MESSAGES')
        ],
        indicatorColor: Color(0xFFFFFFFF),
      )
    )
  );

  final String projectName;
  final String userRole;
  final int messageCount;
  final VoidCallback onMessagePress;
  final VoidCallback onPersonPress;
  final TabController controller;
  final iconBadge;
}
