class Message{
  final String sendBy;
  final  lastMessageTs;
  final String message;
  Message({required this.sendBy,required this.lastMessageTs,required this.message});
  Map<String,dynamic> toJson(){
    return {
      'sendBy':this.sendBy,
      'lastMessageTs':this.lastMessageTs,
      'message':this.message,
    };
  }
}