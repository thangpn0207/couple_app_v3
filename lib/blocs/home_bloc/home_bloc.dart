import 'package:couple_app_v3/blocs/home_bloc/home_event.dart';
import 'package:couple_app_v3/blocs/home_bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeBloc extends Bloc<HomeEvent,HomeState>{
 HomeBloc():super(HomeProfile());
 @override
 Stream<HomeState> mapEventToState(
     HomeEvent event,
     ) async* {
   if (event is ChangeProfile) {
     yield* _mapChangeProfileToState();
   } else if (event is ChangeChatList) {
     yield* _mapChangeChatListToState();
   }
 }

 Stream<HomeProfile> _mapChangeProfileToState() async* {
   yield HomeProfile();
 }

 Stream<HomeChatList> _mapChangeChatListToState() async* {
   yield HomeChatList();
 }
}