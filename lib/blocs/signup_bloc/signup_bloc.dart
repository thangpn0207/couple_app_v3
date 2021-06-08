import 'package:couple_app_v3/blocs/signup_bloc/signup_state.dart';
import 'package:couple_app_v3/blocs/signup_bloc/singup_event.dart';
import 'package:couple_app_v3/services/authentication.dart';
import 'package:couple_app_v3/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:couple_app_v3/locator.dart';
class SignUpBloc extends Bloc<SignUpEvent,SignUpState>{
  final Authentication _authentication= locator<Authentication>();
  SignUpBloc():super(SignUpState.initial());
  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event)async* {
    // TODO: implement mapEventToState
    if(event is SignUpEventEmailChanged){
      yield* _mapSignupEmailChangedToState(event.email);
    }else if(event is SignUpEventPasswordChanged){
      yield* _mapSignupPasswordChangedToState(event.password);
    } else if(event is SignUpEventSubmitted){
      yield*_mapSignupSubmittedState(event.email, event.password);
    }
  }
  Stream<SignUpState> _mapSignupEmailChangedToState(String email) async*{
    yield state.update(isEmailValid: Validators.isValidEmail(email),isPasswordValid: false);
  }
  Stream<SignUpState> _mapSignupPasswordChangedToState(String password)async*{
  yield state.update(isEmailValid: false, isPasswordValid: Validators.isValidPassword(password));
  }
  Stream<SignUpState> _mapSignupSubmittedState(String email,String password)async*{
    yield SignUpState.loading();
    try{
      await _authentication.signUpWithEmailAndPassword(email, password);
      yield SignUpState.success();
    }catch(e){
      print(e);
      yield SignUpState.failure();
    }
  }
}
