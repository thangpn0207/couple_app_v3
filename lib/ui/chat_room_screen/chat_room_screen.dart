import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_bloc.dart';
import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_event.dart';
import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_state.dart';
import 'package:couple_app_v3/model/chat_message.dart';
import 'package:couple_app_v3/model/chat_room.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/ui/chat_room_screen/chat_message_input.dart';
import 'package:couple_app_v3/ui/chat_room_screen/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ChatRoomScreen extends StatefulWidget {
  final UserModel userModel;
  final ChatRoom chatRoomInfo;
  ChatRoomScreen({Key? key,required this.userModel,required this.chatRoomInfo}) : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:   Color(0xffffae88),
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        backgroundColor: Color(0xfffcf3f4),
        centerTitle: false,
        title: Text(
          widget.chatRoomInfo.title,
          style: TextStyle(
            fontSize: 22,
            color: Color(0xff6a515e),
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert,color: Colors.black,),
          ),
        ],
      ),
      body: BlocProvider(create: (context)=>ChatRoomBloc(user: widget.userModel, chatRoomId: widget.chatRoomInfo.id)..add(ChatRoomLoad()),
      child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
        builder: (context, state) {
          if (state is ChatRoomLoadSuccess) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      reverse: true,
                      child: ListView.builder(
                        itemCount: state.messages.length,
                        shrinkWrap: true,
                          itemBuilder: (context,index){
                            return Padding(padding: EdgeInsets.symmetric(vertical: 5),
                            child: MessageItem(userId: widget.userModel.id,message: state.messages[index],),);
                          }),
                      // child: Column(
                      //   children: <Widget>[
                      //     for (var i = 0; i < state.messages.length; i++)
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(vertical: 5),
                      //         child: MessageItem(
                      //           userId: widget.userModel.id,
                      //           message: state.messages[i],
                      //         ),
                      //       )
                      //   ],
                      // ),
                    ),
                  ),
                  ChatMessageInput(
                    onPressed: (message) {
                      BlocProvider.of<ChatRoomBloc>(context).add(
                        SendMessage(
                          message: Message(
                            sendBy: widget.userModel.id,
                            message: message,
                            lastMessageTs:
                            DateTime.now().millisecondsSinceEpoch.toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('Loading'),
            );
          }
        },
      ),)
    );
  }
}
