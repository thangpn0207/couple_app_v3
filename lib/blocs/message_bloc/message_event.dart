import 'package:couple_app_v3/model/chat_message.dart';

abstract class MessageEvent{}
class MessageEventStart extends MessageEvent{
  Message message;
  MessageEventStart({required this.message});
}