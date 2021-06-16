import 'package:couple_app_v3/blocs/message_bloc/message_bloc.dart';
import 'package:couple_app_v3/blocs/message_bloc/message_state.dart';
import 'package:couple_app_v3/model/chat_message.dart';
import 'package:couple_app_v3/utils/constaints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MessageItem extends StatelessWidget {
  final String userId;
  final Message message;
  MessageItem({Key? key, required this.message,required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = userId == message.sendBy;
    return BlocBuilder<MessageBLoc,MessageState>(
      builder: (context,state){
        if(state is MessageStateLoaded){
          return Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: <Widget>[
              isMe ? Container() :Container(
                height: 20,
                width: 20,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(state.userModel.imgUrl??''),
                ),
              ),
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
                  minHeight: 40,
                ),
                child: Text(message.message, style: TextStyle(fontSize: 18,
                  color: isMe ? Colors.white : Colors.black,
                ),),
              )
            ],
          );
        }
        else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
