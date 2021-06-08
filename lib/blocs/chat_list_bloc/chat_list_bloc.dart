import 'dart:async';
import 'package:couple_app_v3/blocs/chat_list_bloc/chat_list_event.dart';
import 'package:couple_app_v3/blocs/chat_list_bloc/chat_list_state.dart';
import 'package:couple_app_v3/locator.dart';
import 'package:couple_app_v3/model/chat_room.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/services/chat_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListBloc extends Bloc<ChatListEvent,ChatListState>{
  final UserModel userModel;
  ChatListBloc({required this.userModel}):super(ChatListInitial());
  ChatService _chatService = locator<ChatService>();
  StreamSubscription ?chatList;
  StreamSubscription ?chatRoomInfoList;

  @override
  Stream<ChatListState> mapEventToState(ChatListEvent event) async*{
    // TODO: implement mapEventToState
  if(event is ChatListStart){
    yield ChatListLoading();
    chatList?.cancel();
    chatList = _chatService.getChatList(userModel.id).listen((list){
      chatRoomInfoList?.cancel();
     if(list.length==0){
       add(ChatListLoaded(chatList: []));
     }else{
       chatRoomInfoList=_chatService.getChatRoomInfo(list).listen((rooms) {
         add(ChatListLoaded(chatList: rooms));
       });
     }
    }
    );
  }else if(event is ChatListLoaded){
    yield* _mapChatListLoadToState(event.chatList);
  }
  }
  Stream<ChatListState> _mapChatListLoadToState(List<ChatRoom> rooms) async* {
    rooms.sort((a, b) {
      return b.lastMessageTs.compareTo(a.lastMessageTs);
    });

    yield ChatListLoadSuccess(chatList: rooms);
  }
  @override
  Future<void> close() {
    chatList?.cancel();
    chatRoomInfoList?.cancel();
    return super.close();
  }
}