import 'package:couple_app_v3/model/user_model.dart';

class ChatRoom{
  final String id;
  final String title;
  final String imgUrl;
  final String lastMessageBy;
  final lastMessage;
  final lastMessageTs;
  ChatRoom({required this.id,required this.title,required this.imgUrl,required this.lastMessageBy,this.lastMessage,this.lastMessageTs});
  Map<String,dynamic> toJson(){
    return {
      'id':this.id,
      'title': this.title,
      'imgUrl': this.imgUrl,
      'lastMessageBy':this.lastMessageBy,
      'lastMessage':this.lastMessage,
      'lastMessageTs':this.lastMessageTs,
    };
  }
}

