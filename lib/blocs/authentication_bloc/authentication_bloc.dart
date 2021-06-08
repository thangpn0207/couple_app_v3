import 'package:couple_app_v3/blocs/authentication_bloc/authentication_event.dart';
import 'package:couple_app_v3/blocs/authentication_bloc/authentication_state.dart';
import 'package:couple_app_v3/locator.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/services/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{
  final Authentication _authentication =locator<Authentication>();
  AuthenticationBloc():super(AuthenticationStateInitial());
  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event)async* {
    // TODO: implement mapEventToState
    if (event is AuthenticationEventStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationEventLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationEventLoggedOut) {
      yield* _mapAuthenticationLoggedOutInToState();
    }
  }
  Stream<AuthenticationState> _mapAuthenticationLoggedOutInToState()async*{
    yield AuthenticationStateFail();
    _authentication.signOut();
  }
  Stream<AuthenticationState> _mapAuthenticationLoggedInToState()async*{
    UserModel userModel = await _authentication.getUser();
    yield AuthenticationStateSuccess(user: userModel);
  }
  Stream<AuthenticationState>_mapAuthenticationStartedToState() async*{
    final isSignedIn = await _authentication.isSignIn();
    print(isSignedIn);
    if(isSignedIn){
      final firebaseUser = await _authentication.getUser();
      yield AuthenticationStateSuccess(user: firebaseUser);
    }else{
      yield AuthenticationStateFail();
    }
  }

}