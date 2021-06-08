import 'dart:async';

import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_event.dart';
import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_state.dart';
import 'package:couple_app_v3/locator.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/services/chat_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent,ChatRoomState>{
 final UserModel user;
 final String chatRoomId;
  ChatRoomBloc({required this.user,required this.chatRoomId}):super(ChatRoomStateInitial());
 ChatService _chatService = locator<ChatService>();
 StreamSubscription? chatRoom;
 @override
  Stream<ChatRoomState> mapEventToState(ChatRoomEvent event) async*{
    // TODO: implement mapEventToState
    if(event is ChatRoomLoad){
      yield ChatRoomLoading();
      chatRoom?.cancel();
      chatRoom = _chatService.getChatMessages(chatRoomId).listen((messages) {
        print(messages);
        add(ReceiveMessage(message: messages));
      });
    }else if(event is ReceiveMessage){
      yield ChatRoomLoadSuccess(messages: event.message);
    }else if(event is SendMessage){
      _chatService.sendChatMessage(chatRoomId, event.message);
      _chatService.setChatRoomLastMessage(chatRoomId, event.message);
    }
  }

 @override
 Future<void> close() {
   chatRoom?.cancel();
   return super.close();
 }
}