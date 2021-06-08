
import 'package:couple_app_v3/model/chat_room.dart';
import 'package:couple_app_v3/model/user_model.dart';

abstract class SearchUserState{}
class SearchUserStateInitial extends SearchUserState{}
class SearchUserStateLoading extends SearchUserState{}
class SearchUserStateLoaded extends SearchUserState{
  final List<UserModel> user;
  SearchUserStateLoaded({required this.user});
}
class GoToChatRoom extends SearchUserState{
   ChatRoom chatRoomInfo;
  String chatRoomId;
  GoToChatRoom({required this.chatRoomId,required this.chatRoomInfo});
}