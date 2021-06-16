import 'package:couple_app_v3/blocs/chat_title_bloc/chat_titile_event.dart';
import 'package:couple_app_v3/blocs/chat_title_bloc/chat_title_state.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/services/repository_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../locator.dart';

class ChatTitleBloc extends Bloc<ChatTitleEvent,ChatTitleState>{
  ChatTitleBloc():super(ChatTitleLoading());
  Repository _repository = locator<Repository>();
  @override
  Stream<ChatTitleState> mapEventToState(ChatTitleEvent event) async*{
    // TODO: implement mapEventToState
    if(event is ChatTitleStart){
      var userChat;
      if(event.chatRoomInfo.lastMessageBy!.isNotEmpty){
        String? userId =event.chatRoomInfo.lastMessageBy;
         var user = await _repository.getUser(userId).then((user){
          if(user==null){
            print('usser unll');

          return UserModel(id: '', email: '', displayName: '', imgUrl: '');
          }else{
            print('usser k co null');
            return user;
          }
        });
         userChat=user;
      }else{
        userChat = UserModel(id: '', email: '', displayName: '', imgUrl: '');
      }
      yield ChatTitleLoaded(chatRoomInfo: event.chatRoomInfo, userModel: userChat);
    }
  }
}