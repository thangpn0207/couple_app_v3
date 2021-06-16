import 'package:couple_app_v3/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:couple_app_v3/blocs/authentication_bloc/authentication_event.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel userModel;

  const ProfileScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffcf3f4),
        centerTitle: false,
        title: Text(
          'My Profile',
          style: TextStyle(
            fontSize: 22,
            color: Color(0xff6a515e),
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: <Widget>[
          //Padding(
          //  padding: const EdgeInsets.all(8.0),
          // child: Icon(Icons.more_vert),
          //  ),
          PopupMenuButton<int>(
            color: Color(0xfffcf3f4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upload photo',
                      textAlign: TextAlign.start,
                    ),
                    Icon(Icons.edit_outlined, color: Colors.black),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logout'),
                    Icon(Icons.logout, color: Colors.black),
                  ],
                ),
              ),
            ],
            onCanceled: () {
              print("You have canceled the menu.");
            },
            onSelected: (value) {
              if(value == 1){
              }else if(value ==2){
                BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationEventLoggedOut());
                print('Logout Success');
              }
            },
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              _topProfile(),
              _midProfile(),
              _bottomProfile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _midProfile() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Color(0xfffcf3f4),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: Color(0xfffae7e9),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Photos',
                    style: TextStyle(
                      color: Color(0xffc7abba),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '3',
                    style: TextStyle(
                      color: Color(0xff6a515e),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Followers',
                    style: TextStyle(
                      color: Color(0xffc7abba),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '0',
                    style: TextStyle(
                      color: Color(0xff6a515e),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Follows',
                    style: TextStyle(
                      color: Color(0xffc7abba),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '0',
                    style: TextStyle(
                      color: Color(0xff6a515e),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomProfile() {
    return Expanded(
      flex: 4,
      child: Container(
        color: Color(0xfffae7e9),
        child: Container(
          padding: const EdgeInsets.only(top: 30, bottom: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
            color: Color(0xfffcf3f4),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/infor/1.jpg',
                    width: 150,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/infor/2.jpg',
                        width: 150,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/images/infor/3.jpg',
                        width: 150,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _topProfile() {
    return Container(
      color: Color(0xfffae7e9),
      child: Container(
        padding: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Color(0xfffcf3f4),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(60),
            )),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userModel.imgUrl??''),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              userModel.displayName??'',
              style: TextStyle(
                fontSize: 25,
                color: Color(0xff6a515e),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${userModel.email}',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xffc7abba),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
