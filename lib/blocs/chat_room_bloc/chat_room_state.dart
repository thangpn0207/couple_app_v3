import 'package:couple_app_v3/model/chat_message.dart';

abstract class ChatRoomState{}
class ChatRoomStateInitial extends ChatRoomState{}
class ChatRoomLoading extends ChatRoomState{}
class ChatRoomLoadSuccess extends ChatRoomState{
  final List<Message> messages;
  ChatRoomLoadSuccess({required this.messages});
}
class ChatRoomLoadFailed extends ChatRoomState{}