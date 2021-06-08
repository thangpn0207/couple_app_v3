import 'package:couple_app_v3/model/user_model.dart';

abstract class SearchEvent{}
class SearchEventLoad extends SearchEvent{
  List<UserModel> users;
  SearchEventLoad({required this.users});
}
class SearchEventButtonPressed extends SearchEvent{
  String displayName;
  SearchEventButtonPressed({required this.displayName});
}
class EventAddChatRoom extends SearchEvent{
  UserModel user;
  UserModel friendUser;
  EventAddChatRoom({required this.user,required this.friendUser});
}