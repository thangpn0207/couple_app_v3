import 'package:couple_app_v3/blocs/chat_list_bloc/chat_list_bloc.dart';
import 'package:couple_app_v3/blocs/chat_list_bloc/chat_list_state.dart';
import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_bloc.dart';
import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_event.dart';
import 'package:couple_app_v3/blocs/chat_title_bloc/chat_titile_bloc.dart';
import 'package:couple_app_v3/blocs/chat_title_bloc/chat_titile_event.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/ui/chat_room_screen/chat_room_screen.dart';
import 'package:couple_app_v3/ui/list_chat_screen/title/chat_list_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: must_be_immutable
class ChatListScreen extends StatefulWidget {
  UserModel userModel;
  ChatListScreen({Key? key,required this.userModel}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatListBloc,ChatListState>(
     builder:(context,state){
       if(state is ChatListLoadSuccess){
         return Expanded(
             child: ListView.builder(
               itemCount: state.chatList.length,
               padding: const EdgeInsets.only(left: 20,right: 20,bottom: 60),
                 itemBuilder: (context,index){
                 print( state.chatList[index]);
                 return GestureDetector(
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                       return BlocProvider(
                         create: (_) => ChatRoomBloc(user: widget.userModel, chatRoomId: state.chatList[index].id??'null')..add(ChatRoomLoad()),
                         child: ChatRoomScreen(
                           userModel: widget.userModel,
                           chatRoomInfo: state.chatList[index],
                         ),
                       );
                     }));
                   },
                   child: Padding(
                     padding: const EdgeInsets.only(bottom: 10),
                     child:  ChatTitle(chatRoomInfo: state.chatList[index] ,),
                     ),
                 );
                 }));

       } else {
         return Center(child: CircularProgressIndicator(),);
       }
     }
    );
  }
}
