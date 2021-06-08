import 'package:couple_app_v3/blocs/login_bloc/login_event.dart';
import 'package:couple_app_v3/blocs/login_bloc/login_state.dart';
import 'package:couple_app_v3/locator.dart';
import 'package:couple_app_v3/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:couple_app_v3/services/authentication.dart';
import 'package:rxdart/rxdart.dart';
class LoginBloc extends Bloc<LoginEvent,LoginState>{
final Authentication _authentication =locator<Authentication>();  //constructor
  LoginBloc():super(LoginState.initial());
  //Give 2 adjacent events a "debounce time"
  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> loginEvents,
      TransitionFunction<LoginEvent, LoginState> transitionFunction,
      ) {
    final debounceStream = loginEvents.where((loginEvent) {
      return (loginEvent is LoginEventEmailChanged || loginEvent is LoginEventPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));//minimum 300ms for each event
    final nonDebounceStream = loginEvents.where((loginEvent) {
      return (loginEvent is! LoginEventEmailChanged && loginEvent is! LoginEventPasswordChanged);
    });
    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), transitionFunction);
  }
  @override
  Stream<LoginState> mapEventToState(LoginEvent loginEvent) async*{
    if (loginEvent is LoginEventEmailChanged) {
      yield* _mapLoginEmailChangeToState(loginEvent.email);
    } else if (loginEvent is LoginEventPasswordChanged) {
      yield* _mapLoginPasswordChangeToState(loginEvent.password);
    } else if (loginEvent is LoginEventWithEmailAndPasswordPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: loginEvent.email, password:loginEvent.password);
    } else if(loginEvent is LoginEventWithGooglePressed){
      yield* _mapLoginWithGoogle();
    }
  }
  Stream<LoginState> _mapLoginEmailChangeToState(String email)async*{
    yield state.cloneAndUpdate(isValidEmail: Validators.isValidEmail(email));
  }
Stream<LoginState> _mapLoginPasswordChangeToState(String password)async*{
  yield state.cloneAndUpdate(isValidEmail: Validators.isValidEmail(password));
}
Stream<LoginState> _mapLoginWithCredentialsPressedToState(
    {required String email, required String password}) async* {
  yield LoginState.loading();
  try {
    await _authentication.signIn(email, password);
    yield LoginState.success();
  } catch (_) {
    yield LoginState.failure();
  }
}
Stream<LoginState> _mapLoginWithGoogle()async*{
  yield LoginState.loading();
  try{
    await _authentication.signInWithGoggle();
    yield LoginState.success();
  }catch(e){
    print(e);
    yield LoginState.failure();

  }
}
}