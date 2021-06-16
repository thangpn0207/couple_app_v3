import 'dart:async';

import 'package:couple_app_v3/blocs/search_user_loc/search_user_event.dart';
import 'package:couple_app_v3/blocs/search_user_loc/search_user_state.dart';
import 'package:couple_app_v3/locator.dart';
import 'package:couple_app_v3/model/chat_room.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/services/chat_service.dart';
import 'package:couple_app_v3/services/repository_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchUserBloc extends Bloc<SearchEvent, SearchUserState> {
  SearchUserBloc() : super(SearchUserStateInitial());
  Repository _repository = locator<Repository>();
  ChatService _chatService = locator<ChatService>();
  StreamSubscription? searchUser;

  @override
  Stream<SearchUserState> mapEventToState(SearchEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SearchEventButtonPressed) {
      yield SearchUserStateLoading();
      searchUser?.cancel();
      searchUser =
          _repository.searchUserInfo(event.displayName).listen((users) {
            add(SearchEventLoad(users: users));
          });
    } else if (event is SearchEventLoad) {
      yield SearchUserStateLoaded(user: event.users);
    }
    else if (event is EventAddChatRoom) {
      yield* _mapAddToState(event.user, event.friendUser);
    }
  }

  Stream<SearchUserState> _mapAddToState(UserModel user,
      UserModel friendModel) async* {
    yield SearchUserStateLoading();
    String chatRoomId = await _chatService.addChatRoom(user, friendModel);
    DocumentSnapshot<Map<String,dynamic>> documentSnapshot = await _repository.getChatRoom(
        chatRoomId);

    ChatRoom chatRoomInfo = ChatRoom(
        id: documentSnapshot.data()!['id'],
        title: documentSnapshot.data()!['title'],
        imgUrl: documentSnapshot.data()!['imgUrl'],
        lastMessageBy: documentSnapshot.data()!['lastMessageBy']);

    yield GoToChatRoom(chatRoomId: chatRoomId, chatRoomInfo: chatRoomInfo);
    @override
    Future<void> close() {
      searchUser?.cancel();
      return super.close();
    }
  }
}
