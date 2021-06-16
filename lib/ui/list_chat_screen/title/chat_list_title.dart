
import 'package:couple_app_v3/blocs/chat_title_bloc/chat_titile_bloc.dart';
import 'package:couple_app_v3/blocs/chat_title_bloc/chat_title_state.dart';
import 'package:couple_app_v3/model/chat_room.dart';
import 'package:couple_app_v3/utils/constaints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTitle extends StatelessWidget {
  ChatRoom chatRoomInfo;
  ChatTitle({Key? key,required this.chatRoomInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundImage: NetworkImage(chatRoomInfo.imgUrl??'null'),
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
                  chatRoomInfo.title??'null',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6a515e),
                  ),
                ),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: chatRoomInfo.lastMessage,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff6a515e),
                    ),

                  ),
                )
              ],
            ),
          ),
          Text(Constants.millisecondsToFormatString(chatRoomInfo.lastMessageTs)),
        ],
      ),
    );
  }
}
