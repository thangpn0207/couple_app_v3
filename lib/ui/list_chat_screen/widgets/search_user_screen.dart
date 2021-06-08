import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_bloc.dart';
import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_event.dart';
import 'package:couple_app_v3/blocs/search_user_loc/search_user_bloc.dart';
import 'package:couple_app_v3/blocs/search_user_loc/search_user_event.dart';
import 'package:couple_app_v3/blocs/search_user_loc/search_user_state.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/services/chat_service.dart';
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
                      BlocProvider.of<SearchUserBloc>(context).add(
                          EventAddChatRoom(
                              user: widget.user,
                              friendUser: state.user[index]));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SearchUserTitle(userModel: state.user[index]),
                    ),
                  );
                }));
      } else if (state is GoToChatRoom) {
        return ChatRoomScreen(userModel: widget.user, chatRoomInfo: state.chatRoomInfo);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
