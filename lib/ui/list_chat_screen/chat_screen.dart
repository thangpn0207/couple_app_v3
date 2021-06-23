import 'package:couple_app_v3/blocs/chat_list_bloc/chat_list_bloc.dart';
import 'package:couple_app_v3/blocs/chat_list_bloc/chat_list_event.dart';
import 'package:couple_app_v3/blocs/chat_screen_bloc/chat_screen_bloc.dart';
import 'package:couple_app_v3/blocs/chat_screen_bloc/chat_screen_event.dart';
import 'package:couple_app_v3/blocs/chat_screen_bloc/chat_screen_state.dart';
import 'package:couple_app_v3/blocs/search_user_loc/search_user_bloc.dart';
import 'package:couple_app_v3/blocs/search_user_loc/search_user_event.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/ui/list_chat_screen/widgets/chat_list_screen.dart';
import 'package:couple_app_v3/ui/list_chat_screen/widgets/search_user_screen.dart';
import 'package:couple_app_v3/utils/constaints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  UserModel userModel;

  ChatScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController searchUserNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcf3f4),
      appBar: AppBar(
        backgroundColor: Color(0xfffcf3f4),
        centerTitle: false,
        title: Text(
          'ChatList',
          style: TextStyle(
            fontSize: 22,
            color: Color(0xff6a515e),
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: BlocBuilder<ChatScreenBloc, ChatScreenState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      _chatScreenBackButton(context, state),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 10,
                          right: 10
                        ),
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: searchUserNameController,
                            autofocus: false,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipOval(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xffffae88),
                                          Color(0xff8f93ea),
                                        ],
                                      ),
                                    ),
                                    child: IconButton(onPressed: (){
                                      BlocProvider.of<ChatScreenBloc>(context).add(ChatScreenEventToSearching());
                                    }, icon: Icon(Icons.search),color: Colors.white70,),
                                  ),
                                ),
                              ),
                              hintText: 'Search...',
                              hintStyle: TextStyle(
                                color: Color(0xffd9c3ce),
                                fontWeight: FontWeight.w300,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: Constants.border,
                              focusedBorder: Constants.border,
                              disabledBorder: Constants.border,
                              enabledBorder: Constants.border,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _chatScreenWidget(context, state)
              ],
            ),
          );
        },
      ),
    );
  }

  _chatScreenWidget(context, state) {
    if (state is ChatScreenStateLoaded) {
      return BlocProvider(
          create: (context) =>
              ChatListBloc(userModel: widget.userModel)..add(ChatListStart()),
          child: ChatListScreen(userModel: widget.userModel,));
    } else if (state is ChatScreenStateSearching) {
      return BlocProvider(
        create: (context) => SearchUserBloc()
          ..add(SearchEventButtonPressed(
              displayName: searchUserNameController.text)),
        child: SearchUserScreen(user: widget.userModel,),
      );
    }
  }

  _chatScreenBackButton(context, state) {
    if (state is ChatScreenStateLoaded) {
      return Container(width: 50,);
    } else if (state is ChatScreenStateSearching) {
      return IconButton(
          onPressed: () {
            // ignore: unnecessary_statements
            BlocProvider.of<ChatScreenBloc>(context)
              ..add(ChatScreenEventBack());
          },
          icon: Container(
            width: 50,
              child: Icon(Icons.arrow_back_ios)));
    }
  }
}
