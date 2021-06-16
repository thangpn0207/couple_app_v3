import 'dart:async';

import 'package:couple_app_v3/blocs/song_list_bloc/song_event.dart';
import 'package:couple_app_v3/blocs/song_list_bloc/song_state.dart';
import 'package:couple_app_v3/services/song_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SongBLoc extends Bloc<SongEvent,SongState>{
  final String chatRoomId;
  SongBLoc({required this.chatRoomId}) : super(SongStateInitial());
  SongService _songService =SongService();
  StreamSubscription? songList;

  @override
  Stream<SongState> mapEventToState(SongEvent event)async* {
    // TODO: implement mapEventToState
    if(event is SongEventStart){
      yield SongStateLoading();
      songList?.cancel();
      songList = _songService.getSongInChatRoom(chatRoomId).listen((songs) {
        add(SongEventLoaded(listSong: songs));
      });
    }else if(event is SongEventLoaded){
      yield SongStateLoadSuccess(listSong: event.listSong);
    }
  }
  @override
  Future<void> close() {
    songList?.cancel();
    return super.close();
  }
}