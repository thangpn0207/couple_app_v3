import 'package:couple_app_v3/model/chat_room.dart';

abstract class ChatListEvent{}
class ChatListStart extends ChatListEvent{}
class ChatListLoaded extends ChatListEvent{
  final List<ChatRoom> chatList;
  ChatListLoaded({required this.chatList});
}