import 'dart:async';

import 'package:couple_app_v3/locator.dart';
import 'package:couple_app_v3/model/chat_message.dart';
import 'package:couple_app_v3/model/chat_room.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/services/repository_service.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:random_string/random_string.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class   ChatService {
  final Repository _repository = locator<Repository>();

  Future<String> addChatRoom(UserModel user, UserModel friendUser) async {
    String chatRoomId = randomAlphaNumeric(13);
    var chatRoomInfo = await _repository.getChatRoom(chatRoomId);
    if (chatRoomInfo.exists) {
      return chatRoomId;
    } else {
      ChatRoom newRoomInfo = ChatRoom(
          id: chatRoomId,
          title: friendUser.displayName,
          imgUrl: friendUser.imgUrl,
          lastMessageBy: '',
        lastMessage: '',
        lastMessageTs: DateTime.now().millisecondsSinceEpoch.toString(),
      );
      await _repository.setChatRoom(newRoomInfo);
      await _repository.updateUserChatList(user.id, chatRoomId);
      await _repository.updateUserChatList(friendUser.id, chatRoomId);
    }
    return chatRoomId;
  }



  Stream<List<ChatRoom>> getChatRoomInfo(List<String>userId) {
    return _repository.getChatRoomInfo(userId).transform(
        documentToChatRoomInfoTransformer);
  }

  StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
      List<ChatRoom>> documentToChatRoomInfoTransformer = StreamTransformer<
      QuerySnapshot<Map<String, dynamic>>,
      List<ChatRoom>>.fromHandlers(
      handleData: (QuerySnapshot<Map<String, dynamic>> snapShot, EventSink<List<ChatRoom>> sink) {
        List<ChatRoom> result = <ChatRoom>[];
        snapShot.docs.forEach((doc) {
          result.add(ChatRoom(
            id: doc['id'],
            title: doc['title'],
            imgUrl: doc['imgUrl'],
            lastMessageBy: doc['lastMessageBy'],
            lastMessageTs: doc['lastMessageTs'],
            lastMessage: doc['lastMessage'],
          ));
        });
        sink.add(result);
      }
  );

  Stream<List<String>> getChatList(userId) {
    return _repository.getChatList(userId).transform(documentToChatListTransformer);
  }
  StreamTransformer<DocumentSnapshot<Map<String, dynamic>>, List<String>> documentToChatListTransformer = StreamTransformer<DocumentSnapshot<Map<String,dynamic>>, List<String>>.fromHandlers(
      handleData: (DocumentSnapshot<Map<String,dynamic>> snapShot, EventSink<List<String>> sink) {
        if (snapShot.exists) {
          sink.add(snapShot.data()!.keys.toList());
        } else {
          sink.add([]);
        }
      }
  );


  Stream<List<Message>> getChatMessages(String chatRoomId) {
    return _repository.getChatMessages(chatRoomId).transform(
        documentToChatMessagesTransformer);
  }

  StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<Message>> documentToChatMessagesTransformer = StreamTransformer<
      QuerySnapshot<Map<String, dynamic>>,
      List<Message>>.fromHandlers(
      handleData: (QuerySnapshot<Map<String, dynamic>> snapShot, EventSink<List<Message>> sink) {
        List<Message> result = <Message>[];
        snapShot.docs.forEach((doc) {
          result.add(Message(
              message: doc['message'],
              sendBy: doc['sendBy'],
              lastMessageTs: doc['lastMessageTs']
          ));
        });
        sink.add(result);
      }
  );
  Future<Map<String,dynamic>?> sendChatMessage(String chatRoomId, Message chatMessage) async {
    return await _repository.sendChatMessage(chatRoomId, chatMessage);
  }

  Future<Map<String,dynamic>?> setChatRoomLastMessage(String chatRoomId, Message chatMessage) async {
    return await _repository.setChatRoomLastMessage(chatRoomId, chatMessage);
  }

}
