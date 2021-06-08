import 'package:couple_app_v3/blocs/chat_screen_bloc/chat_screen_event.dart';
import 'package:couple_app_v3/blocs/chat_screen_bloc/chat_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ChatScreenBloc extends Bloc<ChatScreeEvent,ChatScreenState>{
  ChatScreenBloc():super(ChatScreenStateLoaded());
  @override
  Stream<ChatScreenState> mapEventToState(ChatScreeEvent event) async*{
    // TODO: implement mapEventToState
    if(event is ChatScreenEventToSearching){
      yield ChatScreenStateSearching();
    } else if(event is ChatScreenEventBack){
      yield ChatScreenStateLoaded();
    }
  }

}