import 'package:couple_app_v3/blocs/chat_screen_bloc/chat_screen_bloc.dart';
import 'package:couple_app_v3/blocs/chat_screen_bloc/chat_screen_state.dart';
import 'package:couple_app_v3/blocs/home_bloc/home_bloc.dart';
import 'package:couple_app_v3/blocs/home_bloc/home_event.dart';
import 'package:couple_app_v3/blocs/home_bloc/home_state.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/ui/list_chat_screen/chat_screen.dart';
import 'package:couple_app_v3/ui/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final UserModel userModel;

  const HomeScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: 0);

    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        extendBody: true,
        bottomNavigationBar: SizedBox(
          height: 65,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(45),
              topLeft: Radius.circular(45),
            ),
            child: Container(
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: state.page,
                backgroundColor: Color(0xfffae7e9),
                onTap: (idx) {
                  _pageController.jumpToPage(idx);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    activeIcon: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.blueGrey,
                    ),
                    label:'Profile'
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.chat_bubble,
                      color: Colors.white,
                    ),
                    activeIcon: Icon(
                      Icons.chat_bubble,
                      size: 30,
                      color: Colors.blueGrey,
                    ),
                      label:'Chat'
                  )
                ],
              ),
            ),
          ),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (idx) {
            if (idx == 0) {
              BlocProvider.of<HomeBloc>(context).add(ChangeProfile());
            } else {
              BlocProvider.of<HomeBloc>(context).add(ChangeChatList());
            }
            _pageController.jumpToPage(idx);
          },
          children: <Widget>[
            ProfileScreen(
              userModel: userModel,
            ),
            BlocProvider(
              create: (context) => ChatScreenBloc(),
              child: ChatScreen(userModel: userModel),
            )
          ],
        ),
      );
    });
  }
}
