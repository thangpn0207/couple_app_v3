import 'package:couple_app_v3/model/song.dart';

abstract class SongState{}
class SongStateInitial extends SongState{}
class SongStateLoading extends SongState{}
class SongStateLoadSuccess extends SongState{
  List<Song> listSong;
  SongStateLoadSuccess({required this.listSong});
}
