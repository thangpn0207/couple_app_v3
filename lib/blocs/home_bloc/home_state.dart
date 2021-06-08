abstract class HomeState{
  final int page;
  HomeState(this.page);
}
class HomeProfile extends HomeState{
  HomeProfile():super(0);
}
class HomeChatList extends HomeState{
  HomeChatList():super(1);
}