import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_app_v3/model/chat_message.dart';
import 'package:couple_app_v3/model/chat_room.dart';
import 'package:couple_app_v3/model/song.dart';
import 'package:couple_app_v3/model/user_model.dart';

class Repository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

//user
  Stream<QuerySnapshot> searchUserByName(String displayName) {
    return _firebaseFirestore
        .collection('users')
        .where("displayName", isEqualTo: displayName)
        .snapshots();
  }

  Stream<List<UserModel>> searchUserInfo(displayName) {
    return searchUserByName(displayName)
        .transform(documentToUserInfoTransformer);
  }

  StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<UserModel>>
      documentToUserInfoTransformer =
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<UserModel>>.fromHandlers(handleData:
          (QuerySnapshot<Map<String, dynamic>> snapShot, EventSink<List<UserModel>> sink) {
    List<UserModel> result = <UserModel>[];
    snapShot.docs.forEach((doc) {
      result.add(UserModel(
          id: doc['id'],
          displayName: doc['displayName'],
          email: doc['email'],
          imgUrl: doc['imgUrl']));
    });
    sink.add(result);
  });

  Future<UserModel?> getUser(String? id) async {
    var doc = await _firebaseFirestore.collection('users').doc(id).get();
    return UserModel(
        id: doc.data()!['id'],
        email: doc.data()!['email'],
        displayName: doc.data()!['displayName'],
        imgUrl: doc.data()!['imgUrl']);
  }

  Future<void> registerUser(UserModel user) async {
    _firebaseFirestore.collection('users').doc(user.id).set({
      'id': user.id,
      'email': user.email,
      'displayName': user.displayName,
      'imgUrl': user.imgUrl
    });
  }

  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return _firebaseFirestore.collection("users").doc(userId).set(userInfoMap);
  }

  //get chat room
  Future<void> setChatRoom(ChatRoom chatRoomInfo) async {
    return await _firebaseFirestore
        .collection('chatRooms')
        .doc(chatRoomInfo.id)
        .set(chatRoomInfo.toJson());
  }
  // Future<DocumentSnapshot> getChatRoom(String chatRoomId) async {
  //   return await _firebaseFirestore.collection('chatRooms').doc(chatRoomId).get();
  // }

  Future<void> updateUserChatList(String? userId, String chatRoomId) async {
    var chatListDoc =
    await _firebaseFirestore.collection('userAndChats').doc(userId).get();
    if (chatListDoc.exists) {
      return chatListDoc.reference.update({chatRoomId: true});
    } else {
      return chatListDoc.reference.set({chatRoomId: true});
    }
  }
  Stream<DocumentSnapshot>getChatList(String id) {
    return _firebaseFirestore.collection('userAndChats').doc(id).snapshots();
  }

  Stream<QuerySnapshot> getChatMessages(String chatRoomId) {
    return _firebaseFirestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('lastMessageTs', descending: false)
        .snapshots();
  }
  Future<DocumentSnapshot<Map<String,dynamic>>> getChatRoom(String chatRoomId) async {
    return await _firebaseFirestore.collection('chatRooms').doc(chatRoomId).get();
  }

  Stream<QuerySnapshot> getChatRoomInfo(List<String> chatId) {
    return _firebaseFirestore
        .collection('chatRooms')
        .where('id', whereIn: chatId)
        .snapshots();
  }

  Future<Map<String,dynamic>?> sendChatMessage(String chatRoomId, Message chatMessage) async {
    var reference = _firebaseFirestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .doc(chatMessage.lastMessageTs);

    return _firebaseFirestore.runTransaction((transaction) async {
      await transaction.set(reference, {
        'message': chatMessage.message,
        'lastMessageTs': chatMessage.lastMessageTs,
        'sendBy': chatMessage.sendBy,
      });
    });
  }
  Future<Map<String,dynamic>?> setChatRoomLastMessage(
      String chatRoomId, Message chatMessage) async {
    var reference = _firebaseFirestore.collection('chatRooms').doc(chatRoomId);

    return _firebaseFirestore.runTransaction((transaction) async {
      await transaction.update(reference, {
        'lastMessage': chatMessage.message,
        'lastMessageTs': chatMessage.lastMessageTs,
      });
    });
  }
//song
  Future<void> uploadSong(Song song,String chatRoomId) async{
   return await FirebaseFirestore.instance
       .collection('chatRooms')
       .doc(chatRoomId)
       .collection('songs')
        .doc(song.songName)
        .set(song.toJson())
        .whenComplete(() => print('upload success'));
  }
  Stream<QuerySnapshot> getSongInChatRoom(String chatRoomId) {
    return _firebaseFirestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('songs')
        .orderBy('songName', descending: false)
        .snapshots();
  }
}
