import 'package:flutter/material.dart';

class ChatNavigationBar extends AppBar {

  ChatNavigationBar({
    Key key,
    this.messageCount,
    this.iconBadge,
    @required this.projectName,
    @required this.onMessagePress,
    @required this.controller,
  }) : super(
      key: key,
      leading: BackButton(),
      title: Text(projectName),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Stack(
            overflow: Overflow.visible,
            children: [
              Icon(Icons.message),
              Positioned(
                top: -5.0,
                left: 13.0,
                child: messageCount != null
                  ? iconBadge(messageCount)
                  : SizedBox() 
              )
            ],
          ),
          onPressed: onMessagePress
        )
      ],
      bottom: PreferredSize( 
        preferredSize: const Size.fromHeight(48.0),
        child: TabBar(
          controller: controller,
          tabs: <Tab>[
            Tab(text: 'SCOPE'),
            Tab(text: 'MESSAGES')
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
