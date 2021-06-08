import 'dart:async';

import 'package:couple_app_v3/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:couple_app_v3/blocs/authentication_bloc/authentication_event.dart';
import 'package:couple_app_v3/blocs/authentication_bloc/authentication_state.dart';
import 'package:couple_app_v3/blocs/home_bloc/home_bloc.dart';
import 'package:couple_app_v3/blocs/login_bloc/login_bloc.dart';
import 'package:couple_app_v3/ui/home_screen/home_screen.dart';
import 'package:couple_app_v3/ui/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen() : super();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), () {
      BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationEventStarted());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state){
        if (state is AuthenticationStateSuccess) {
          return BlocProvider<HomeBloc>(
            create: (context)=>HomeBloc(),
            child: HomeScreen(userModel: state.user,),
          );
        } else if (state is AuthenticationStateFail) {
          return BlocProvider<LoginBloc>(
            create: (context)=>LoginBloc(),
            child: LoginScreen(),
          );
        }
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                'assets/images/splash/background.png',
              ))),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    Center(
                        child: Container(
                            child:
                                Image.asset('assets/images/splash/house.png'))),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        child: Text(
                      'Welcome To Home',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      child: Image.asset('assets/logo/logomain.png'),
                    ),
                    CircularProgressIndicator(
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ,
    );
  }
}
