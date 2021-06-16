import 'package:couple_app_v3/blocs/music_bloc/music_state.dart';
import 'package:couple_app_v3/blocs/music_bloc/music_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
class MusicBloc extends Bloc<MusicEvent,MusicState>{
  String url;
  MusicBloc({required this.url}):super(MusicStateFail());
  AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPlaying =false;
  @override
  Stream<MusicState> mapEventToState(MusicEvent event)async* {
    // TODO: implement mapEventToState
    if(event is MusicStart){
      yield MusicStateLoading();
      try{
        _audioPlayer.setUrl(url);
        _audioPlayer.onDurationChanged.listen((d) {
          print(d);
          _duration=d;
          add(MusicLoadSuccess(newDuration: _duration,newPosition: Duration.zero));
        });
      }catch(e){
        print('eerrre');
        yield MusicStateFail();
      }
    }else if(event is MusicLoadSuccess){
      print('hear');
      _audioPlayer.onPlayerStateChanged.listen((state) {
        if(state==PlayerState.PLAYING){
          isPlaying=true;
        }else{
          isPlaying=false;
        }
      });

      print(event.newPosition);
      yield MusicStateLoaded(newDuration: event.newDuration, isPlaying: isPlaying, newPosition: event.newPosition);
    } else if( event is MusicEventOnPressedButtonRunOrPause){
      if(_audioPlayer.state==PlayerState.PLAYING){
        _audioPlayer.pause();
        isPlaying=false;
      }else{
        _audioPlayer.play(url);
        _audioPlayer.onAudioPositionChanged.listen((p) {
          _position=p;
          add(MusicLoadSuccess(newDuration: _duration,newPosition: _position));
        });
      }
      yield MusicStateLoaded(newDuration: event.newDuration, isPlaying: isPlaying, newPosition: event.newPosition);
    } else if(event is OnButtonFast){
      _audioPlayer.setPlaybackRate(playbackRate: 1.5);
    }else if(event is OnButtonBack){
      _audioPlayer.setPlaybackRate(playbackRate: 0.5);
    }else if(event is OnChangeSlide){
      Duration newDuration = Duration(seconds: event.second);
      _audioPlayer.seek(newDuration);
    } else if(event is OnCloseButton){
      _audioPlayer.stop();
    }
  }
}