import 'package:couple_app_v3/model/chat_message.dart';

abstract class ChatRoomEvent{}
class ChatRoomLoad extends ChatRoomEvent{}
class SendMessage extends ChatRoomEvent{
  final Message message;
  SendMessage({required this.message});
}
class ReceiveMessage extends ChatRoomEvent{
  final List<Message> message;
  ReceiveMessage({required this.message});
}