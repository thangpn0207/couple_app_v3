import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_bloc.dart';
import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_event.dart';
import 'package:couple_app_v3/blocs/chat_room_bloc/chat_room_state.dart';
import 'package:couple_app_v3/blocs/message_bloc/message_bloc.dart';
import 'package:couple_app_v3/blocs/message_bloc/message_event.dart';
import 'package:couple_app_v3/blocs/music_bloc/music_bloc.dart';
import 'package:couple_app_v3/blocs/music_bloc/music_event.dart';
import 'package:couple_app_v3/blocs/music_bloc/music_state.dart';
import 'package:couple_app_v3/locator.dart';
import 'package:couple_app_v3/model/chat_message.dart';
import 'package:couple_app_v3/model/chat_room.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/services/song_service.dart';
import 'package:couple_app_v3/ui/chat_room_screen/chat_message_input.dart';
import 'package:couple_app_v3/ui/chat_room_screen/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'list_songs.dart';

class ChatRoomScreen extends StatefulWidget {
  final UserModel userModel;
  final ChatRoom chatRoomInfo;

  ChatRoomScreen(
      {Key? key, required this.userModel, required this.chatRoomInfo})
      : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  bool check = false;
  String path = '';
  final SongService _songService = locator<SongService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffae88),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          backgroundColor: Color(0xfffcf3f4),
          centerTitle: false,
          title: Text(
            widget.chatRoomInfo.title ?? '',
            style: TextStyle(
              fontSize: 22,
              color: Color(0xff6a515e),
              fontWeight: FontWeight.w300,
            ),
          ),
          actions: <Widget>[
            PopupMenuButton<int>(
              color: Color(0xfffcf3f4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Song',
                        textAlign: TextAlign.start,
                      ),
                      Icon(Icons.list, color: Colors.black),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Upload Song'),
                      Icon(Icons.cloud_upload_rounded, color: Colors.black),
                    ],
                  ),
                ),
              ],
              onCanceled: () {
                print("You have canceled the menu.");
              },
              onSelected: (value) {
                if (value == 1) {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListSongs(
                                  chatRoomId: widget.chatRoomInfo.id ?? '')))
                      .then((value) {
                        if(value!=null){
                          check=true;
                          path=value;
                          print(path);
                          setState(() {
                          });
                        }
                        else{
                          check=false;
                          path='';
                        }
                  });
                } else if (value == 2) {
                  _songService.selectSong(widget.chatRoomInfo.id??'');
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: BlocProvider(
          create: (context) => ChatRoomBloc(
              user: widget.userModel, chatRoomId: widget.chatRoomInfo.id ?? '')
            ..add(ChatRoomLoad()),
          child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
            builder: (context, state) {
              if (state is ChatRoomLoadSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      check ? playMusic(context, path) : Container(),
                      Expanded(
                        child: SingleChildScrollView(
                          reverse: true,
                          child: ListView.builder(
                              itemCount: state.messages.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return BlocProvider(
                                  create: (_) => MessageBLoc()
                                    ..add(MessageEventStart(
                                        message: state.messages[index])),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: MessageItem(
                                      userId: widget.userModel.id ?? '',
                                      message: state.messages[index],
                                    ),
                                  ),
                                );
                              }),
                          // child: Column(
                          //   children: <Widget>[
                          //     for (var i = 0; i < state.messages.length; i++)
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(vertical: 5),
                          //         child: MessageItem(
                          //           userId: widget.userModel.id,
                          //           message: state.messages[i],
                          //         ),
                          //       )
                          //   ],
                          // ),
                        ),
                      ),
                      ChatMessageInput(
                        onPressed: (message) {
                          BlocProvider.of<ChatRoomBloc>(context).add(
                            SendMessage(
                              message: Message(
                                sendBy: widget.userModel.id ?? '',
                                message: message,
                                lastMessageTs: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text('Loading'),
                );
              }
            },
          ),
        ));
  }

  Widget playMusic(BuildContext context, String path) {
    List<IconData> _icons = [Icons.play_circle_fill, Icons.pause_circle_filled];
    return BlocProvider<MusicBloc>(
      create: (context) => MusicBloc(url: path)..add(MusicStart()),
      child: BlocBuilder<MusicBloc, MusicState>(
        builder: (context, state) {
          if (state is MusicStateLoaded) {
            return Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
                color: Colors.white
              ),
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          check=false;
                          BlocProvider.of<MusicBloc>(context)
                              .add(OnCloseButton());
                          setState(() {
                          });
                        },
                        icon: Icon(Icons.close),
                        color: Colors.black,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.newPosition.toString().split('.')[0],
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          state.newDuration.toString().split('.')[0],
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Slider(
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      value: state.newPosition.inSeconds.toDouble(),
                      min: 0.0,
                      max: state.newDuration.inSeconds.toDouble(),
                      onChanged: (double value) {
                        BlocProvider.of<MusicBloc>(context)
                            .add(OnChangeSlide(second: value.toInt()));
                        value = value;
                      }),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<MusicBloc>(context)
                                  .add(OnButtonBack());
                            },
                            icon: Icon(Icons.fast_rewind_outlined)),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<MusicBloc>(context, listen: false)
                                .add(MusicEventOnPressedButtonRunOrPause(
                                    newDuration: state.newDuration,
                                    newPosition: state.newPosition));
                          },
                          icon: state.isPlaying
                              ? Icon(
                                  _icons[1],
                                  size: 50,
                                  color: Colors.blue,
                                )
                              : Icon(_icons[0], size: 50,
                            color: Colors.blue,),
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<MusicBloc>(context)
                                  .add(OnButtonFast());
                            },
                            icon: Icon(Icons.fast_forward_outlined))
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
