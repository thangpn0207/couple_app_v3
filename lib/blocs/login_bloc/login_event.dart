
abstract class LoginEvent {
  const LoginEvent();
}
class LoginEventEmailChanged extends LoginEvent {
  final String email;
  //constructor
   LoginEventEmailChanged({required this.email});
  @override
  String toString() => 'Email changed: $email';
}

class LoginEventPasswordChanged extends LoginEvent {
  final String password;
  //constructor
   LoginEventPasswordChanged({required this.password});
  @override
  String toString() => 'Password changed: $password';
}
class LoginEventWithGooglePressed extends LoginEvent{}
class LoginEventWithEmailAndPasswordPressed extends LoginEvent {
  final String email;
  final String password;
  const LoginEventWithEmailAndPasswordPressed({
    required this.email,
    required this.password
  });
  @override
  String toString() => 'LoginEventWithEmailAndPasswordPressed, email = $email, password = $password';
}