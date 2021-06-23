import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class GoogleLoginButton extends StatelessWidget {
  VoidCallback _onPressed;
  GoogleLoginButton({Key? key,required VoidCallback onPressed}) :
        _onPressed=onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        width: 364,
        height: 67,
        child: ButtonTheme(
            child: ElevatedButton.icon(
              onPressed:
                _onPressed,
              icon: Icon(FontAwesomeIcons.google,color: Colors.white,size: 18,),
              label: Text(
                "SignIn with Google",
                style: TextStyle(color: Colors.white,fontSize: 18),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.redAccent)
                    )
                ),
              ),
            )
        ),
      ),
    );
  }
}
