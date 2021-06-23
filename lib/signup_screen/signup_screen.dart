import 'package:couple_app_v3/blocs/login_bloc/login_bloc.dart';
import 'package:couple_app_v3/signup_screen/buttons/signup_button.dart';
import 'package:couple_app_v3/ui/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/login/Background.png'))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
                child: Center(child: Image.asset('assets/logo/logomain.png')),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Text(
                  'SignUp',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 15, bottom: 20),
                child: Text(
                  'Enter your email and password',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin:
                EdgeInsets.only(top: 10, left: 15, bottom: 20, right: 15),
                child: TextFormField(
                  style: TextStyle(fontSize: 18),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                margin:
                EdgeInsets.only(top: 10, left: 15, bottom: 20, right: 15),
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(),
                        child: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      )),
                ),
              ),
              Container(
                margin:
                EdgeInsets.only(top: 10, left: 15, bottom: 5, right: 15),
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(),
                        child: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      )),
                ),
              ),
              Container(
                margin:
                EdgeInsets.only(top: 5, left: 15, right: 15),
                child: Row(
                  children: [
                    Text('By continuing you agree  to our'),
                    TextButton(onPressed: () {},
                      child: Text('Terms of Service',
                        style: TextStyle(color: Colors.orangeAccent),),),
                  ],
                ),
              ),
              Container(
                margin:
                EdgeInsets.only( left: 15, right: 15),
                child: Row(
                  children: [
                    Text('and'),
                    TextButton(onPressed: () {
                    }, child: Text('Privacy Policy',style: TextStyle(color: Colors.orangeAccent),))
                  ],
                ),
              ),
              SignUpButton(onPressed: () {}),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ? ',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.redAccent),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
