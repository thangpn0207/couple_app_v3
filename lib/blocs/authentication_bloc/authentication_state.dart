import 'package:couple_app_v3/model/user_model.dart';

abstract class AuthenticationState{
  const AuthenticationState();
}
class AuthenticationStateInitial extends AuthenticationState{
}
class AuthenticationStateSuccess extends AuthenticationState{
  final UserModel user;
  const AuthenticationStateSuccess({required this.user});
}
class AuthenticationStateFail extends AuthenticationState{}