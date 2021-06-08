import 'package:couple_app_v3/model/chat_room.dart';
import 'package:couple_app_v3/utils/constaints.dart';
import 'package:flutter/material.dart';

class ChatTitle extends StatelessWidget {
  final ChatRoom chatRoom;
  ChatTitle({Key? key,required this.chatRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Row(
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            child: CircleAvatar(
              backgroundImage: NetworkImage(chatRoom.imgUrl),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  chatRoom.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6a515e),
                  ),
                ),
                Text(
                  chatRoom.lastMessage,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff6a515e),
                  ),
                )
              ],
            ),
          ),
          Text(Constants.millisecondsToFormatString(chatRoom.lastMessageTs)),
        ],
      ),
    );
  }
}
