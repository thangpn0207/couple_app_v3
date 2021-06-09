import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_bloc.dart';
import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_event.dart';
import 'package:couple_app_v3/blocs/search_user_loc/search_user_bloc.dart';
import 'package:couple_app_v3/blocs/search_user_loc/search_user_state.dart';
import 'package:couple_app_v3/model/chat_room.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/services/chat_service.dart';
import 'package:couple_app_v3/services/repository_service.dart';
import 'package:couple_app_v3/ui/chat_room_screen/chat_room_screen.dart';
import 'package:couple_app_v3/ui/list_chat_screen/title/search_user_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../locator.dart';

class SearchUserScreen extends StatefulWidget {
  UserModel user;

  SearchUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  _SearchUserScreenState createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  ChatService _chatService = locator<ChatService>();
  Repository _repository = locator<Repository>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchUserBloc, SearchUserState>(builder: (context, state) {
      if (state is SearchUserStateLoaded) {
        print(state.user.length);
        return Expanded(
            child: ListView.builder(
                itemCount: state.user.length,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      String chatRoomId = await _chatService.addChatRoom(widget.user, state.user[index]);
                      DocumentSnapshot documentSnapshot = await _repository.getChatRoom(
                          chatRoomId);
                      ChatRoom chatRoomInfo = ChatRoom(
                          id: documentSnapshot.data()['id'],
                          title: documentSnapshot.data()['title'],
                          imgUrl: documentSnapshot.data()['imgUrl'],
                          lastMessageBy: documentSnapshot.data()['lastMessageBy']);
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return BlocProvider(
                          create: (_) => ChatRoomBloc(user: widget.user, chatRoomId: chatRoomInfo.id)..add(ChatRoomLoad()),
                          child: ChatRoomScreen(
                            userModel: widget.user,
                            chatRoomInfo: chatRoomInfo,
                          ),
                        );
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SearchUserTitle(userModel: state.user[index]),
                    ),
                  );
                }));
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

}
