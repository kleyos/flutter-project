import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  
  ChatMessage({
    Key key,
    @required this.item,
    @required this.isOwner,
  }) : super(key: key);
  
  final item;
  final bool isOwner;
  
  Widget _whiteContainerRow() {
    return new Row(
      children: <Widget>[
        !isOwner 
          ? new Image.asset('assets/images/right.png',
              height: 18.0,
              width: 15.0,
            )
          : new SizedBox(),
        new Expanded(
          child: new Container(
            constraints: new BoxConstraints(
              minHeight: 80.0,
            ),
            padding: const EdgeInsets.all(12.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),        
            child: new Text(item['body'],
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17.0,
                color: Colors.black,
              ),
            ),
          )
        ),
        isOwner 
          ? new Image.asset('assets/images/left.png',
              height: 18.0,
              width: 15.0,
            )
          : new SizedBox()
      ]
    );
  }

  Widget _authorRow() {
    return new Container (
      margin: EdgeInsets.only(right: 10.0, bottom: 4.0),
      child: new Row(
        mainAxisAlignment: isOwner ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Text(item['author'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Colors.teal,
            ),
          ),
          new SizedBox(width: 8.0),
          new Text(item['time'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(193, 193, 193, 1.0),
              fontSize: 12.0,
            ),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.all(10.0),
          padding: isOwner 
            ? const EdgeInsets.fromLTRB(60.0, 0.0, 5.0, 0.0)
            : const EdgeInsets.fromLTRB(5.0, 0.0, 60.0, 0.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Container(
                margin: isOwner 
                  ? const EdgeInsets.only(right: 25.0)
                  : const EdgeInsets.only(left: 25.0),
                child: _authorRow(),
              ),
              _whiteContainerRow()
            ]
          )
        )
      ]
    );
  }
}
