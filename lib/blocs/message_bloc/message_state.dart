import 'package:couple_app_v3/model/chat_message.dart';
import 'package:couple_app_v3/model/user_model.dart';

abstract class MessageState{}
class MessageStateLoading extends MessageState{}
class MessageStateLoaded extends MessageState{
  Message message;
  UserModel  userModel;
  MessageStateLoaded({required this.userModel,required this.message});
}