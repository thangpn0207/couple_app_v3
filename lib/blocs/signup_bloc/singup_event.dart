abstract class SignUpEvent{}
class SignUpEventEmailChanged extends SignUpEvent{
  final String email;
  SignUpEventEmailChanged({required this.email});
}
class SignUpEventPasswordChanged extends SignUpEvent{
  final String password;
  SignUpEventPasswordChanged({required this.password});
}
class SignUpEventSubmitted extends SignUpEvent{
  final String email;
  final String password;
  SignUpEventSubmitted({required this.email,required this.password});
}