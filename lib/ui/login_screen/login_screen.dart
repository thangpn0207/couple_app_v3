import 'package:couple_app_v3/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:couple_app_v3/blocs/authentication_bloc/authentication_event.dart';
import 'package:couple_app_v3/blocs/login_bloc/login_bloc.dart';
import 'package:couple_app_v3/blocs/login_bloc/login_event.dart';
import 'package:couple_app_v3/blocs/login_bloc/login_state.dart';
import 'package:couple_app_v3/signup_screen/signup_screen.dart';
import 'package:couple_app_v3/ui/login_screen/buttons/google_button.dart';
import 'package:couple_app_v3/ui/login_screen/buttons/logging_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = true;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isFailure) {
              print('login state fail');
              Scaffold.of(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Login Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ));
            } else if (state.isSubmitting) {
              print('login state Submid');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Logging In...',textAlign: TextAlign.center,),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ));
            } else if (state.isSuccess) {
              print('login state Success');
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationEventLoggedIn());
            } else{
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Waiting...'),
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      ],
                    ),
                    backgroundColor: Color(0xffffae88),
                  )
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage('assets/images/login/Background.png'))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Container(
                        height: 100,
                        child: Center(
                            child: Image.asset('assets/logo/logomain.png')),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Text(
                          'Logging',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
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
                        margin: EdgeInsets.only(
                            top: 10, left: 15, bottom: 20, right: 15),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 10, left: 15, bottom: 20, right: 15),
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
                      LoggingButton(onPressed: _onFormSubmitted),
                      GoogleLoginButton(onPressed: _onGooglePressed),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\' have an account ? ',
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()));
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(color: Colors.redAccent),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChange() {
    _loginBloc.add(LoginEventEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _loginBloc
        .add(LoginEventPasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginEventWithEmailAndPasswordPressed(
        email: _emailController.text, password: _passwordController.text));
  }

  void _onGooglePressed() {
    _loginBloc.add(LoginEventWithGooglePressed());
  }
  Future<void> _showMyDialog(String text){
    return showDialog<void>(
      context: context,
        barrierDismissible:false,
      builder: (BuildContext context) => AlertDialog(
        title: Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        content: Center(child: CircularProgressIndicator()),
      ),
    );
  }

}
