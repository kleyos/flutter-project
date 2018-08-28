import 'package:flutter/material.dart';
import 'package:add_just/ui/shared/background-image.dart';
import 'package:add_just/ui/chat/chat-message.dart';

class ChatView extends StatelessWidget {

  ChatView({
    @required this.owner,
    Key key,
  }) : super(key: key);

  final owner;
  final _messages = [
    {
      'id': 12,
      'author': 'Leonard Loew',
      'time': '57 min ago',
      'body': 'Can you sent me the drawings?'
    },
    {
      'id': 9999,
      'author': 'John Smith',
      'time': '5 min ago',
      'body': 'Done'
    },
    {
      'id': 9999,
      'author': 'John Smith',
      'time': '2 min ago',
      'body': 'Yes'
    },
  ];
  
  List<ChatMessage> _loadMessages() {
    return _messages.map((item) => ChatMessage(item: item, isOwner: owner == item['id'])).toList();
  }
  
  Widget _listMessages(List<ChatMessage> messages) {
    return new ListView.builder(
      reverse: false,
      itemBuilder: (_, int idx) => messages[idx],
      itemCount: messages.length
    );
  }
  Widget _chatField() {
    final TextEditingController _controller = TextEditingController();
    
    return new TextField(
      controller: _controller,
      decoration: new InputDecoration(
        hintText: 'Type message here',
        hintStyle: TextStyle(
          fontStyle: FontStyle.italic,
        ),
        suffixIcon: new Icon(Icons.photo_camera, size: 35.0,),
        fillColor: Color.fromRGBO(255, 255, 255, 1.0),
        contentPadding: EdgeInsets.all(10.0),
        filled: true,
      ),
    ); 
  }
  
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        BackgroundImage(),
        new Container(
          child: new Column (
            children: <Widget>[
              new Expanded(
                child: _listMessages(_loadMessages())
              ),
              _chatField(),
            ],
          )
        )
      ]
    );
  }
}
