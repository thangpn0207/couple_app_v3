import 'package:couple_app_v3/model/chat_message.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final String userId;
  final Message message;
  MessageItem({Key? key, required this.message,required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = userId == message.sendBy;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: isMe ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
              borderRadius: isMe ? BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ) : BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
            minHeight: 30,
          ),
          child: Text(message.message, style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
          ),),
        )
      ],
    );
  }
}
