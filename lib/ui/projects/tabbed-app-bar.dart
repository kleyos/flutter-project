import 'package:flutter/material.dart';

class TabbedAppBar extends AppBar {

  TabbedAppBar({
    Key key,
    this.messageCount,
    this.iconBadge,
    @required this.projectName,
    @required this.onMessagePress,
    @required this.controller,
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
      )
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
  final int messageCount;
  final Function onMessagePress;
  final TabController controller;
  final iconBadge;
}
