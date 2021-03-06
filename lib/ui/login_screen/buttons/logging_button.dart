import 'package:flutter/material.dart';

class LoggingButton extends StatelessWidget {
  VoidCallback _onPressed;
  LoggingButton({Key? key,required VoidCallback onPressed}) :
        _onPressed=onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 5),
        width: 364,
        height: 67,
        child: ButtonTheme(
            child: ElevatedButton(
              onPressed: _onPressed,
              child: Text(
                "Login",
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
