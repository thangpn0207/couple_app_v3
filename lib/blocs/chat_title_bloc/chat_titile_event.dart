import 'package:couple_app_v3/model/chat_room.dart';

abstract class ChatTitleEvent{}
class ChatTitleStart extends ChatTitleEvent{
  ChatRoom chatRoomInfo;
  ChatTitleStart({required this.chatRoomInfo});
}