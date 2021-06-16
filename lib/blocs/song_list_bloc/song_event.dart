import 'package:couple_app_v3/model/song.dart';

abstract class SongEvent{}
class SongEventStart extends SongEvent{}
class SongEventLoaded extends SongEvent{
  List<Song> listSong;
  SongEventLoaded({required this.listSong});
}