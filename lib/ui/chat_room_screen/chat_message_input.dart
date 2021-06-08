import 'package:couple_app_v3/utils/constaints.dart';
import 'package:flutter/material.dart';

class ChatMessageInput extends StatelessWidget {
  final Function onPressed;
   ChatMessageInput({Key? key, required this.onPressed}) : super(key: key);
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Please enter the message',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: Constants.border,
                disabledBorder: Constants.border,
                border: Constants.border,
                errorBorder: Constants.border,
                focusedBorder: Constants.border,
                focusedErrorBorder: Constants.border,
              ),

            ),
          ),
          Container(
            height: 50,
            width: 50,
            child: IconButton(
              onPressed: () {
                onPressed(_controller.text);
                _controller.clear();
              },
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
          ),
        ],
      ),
    );
  }
}
