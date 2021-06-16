import 'package:couple_app_v3/model/chat_room.dart';
import 'package:couple_app_v3/model/user_model.dart';

abstract class ChatTitleState{}
class ChatTitleLoading extends ChatTitleState{
}
class ChatTitleLoaded extends ChatTitleState{
  ChatRoom chatRoomInfo;
  UserModel userModel;
  ChatTitleLoaded({required this.chatRoomInfo,required this.userModel});
}