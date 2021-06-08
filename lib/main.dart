import 'package:couple_app_v3/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:couple_app_v3/blocs/authentication_bloc/authentication_event.dart';
import 'package:couple_app_v3/locator.dart';
import 'package:couple_app_v3/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'APP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primarySwatch: Colors.red,
    ),
    home: BlocProvider<AuthenticationBloc>(
    create:(context) =>AuthenticationBloc(),
    child: SplashScreen(
    ),
    ));
  }
}
