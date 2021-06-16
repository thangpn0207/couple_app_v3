import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple_app_v3/locator.dart';
import 'package:couple_app_v3/model/song.dart';
import 'package:couple_app_v3/services/repository_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SongService{
  final Repository _repository = locator<Repository>();

  void selectSong(String chatRoomId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio,withData:true );
    if (result != null) {
      File file = File(result.files.single.path??'');
      // print('file ${file.readAsBytesSync()}');
      Uint8List fileBytes = file.readAsBytesSync();

      String fileName = result.files.first.name;
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('upload/$fileName')
          .putData(fileBytes);
      String dowUrl = await FirebaseStorage.instance
          .ref('upload/$fileName')
          .getDownloadURL();
      Song dataSong = new Song(songUrl: dowUrl, songName: fileName);
      await _repository.uploadSong(dataSong, chatRoomId);
    } else {
      print('can selectfile');
    }
  }
  Stream<List<Song>> getSongInChatRoom(String chatRoomId) {
    return _repository.getSongInChatRoom(chatRoomId).transform(
        documentToChatMessagesTransformer);
  }

  StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<Song>> documentToChatMessagesTransformer = StreamTransformer<
      QuerySnapshot<Map<String, dynamic>>,
      List<Song>>.fromHandlers(
      handleData: (QuerySnapshot<Map<String, dynamic>> snapShot, EventSink<List<Song>> sink) {
        List<Song> result = <Song>[];
        snapShot.docs.forEach((doc) {
          result.add(Song(
              songName: doc['songName'],
              songUrl: doc['songUrl'],
          ));
        });
        sink.add(result);
      }
  );
}