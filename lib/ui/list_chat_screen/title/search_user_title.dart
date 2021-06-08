import 'package:couple_app_v3/model/user_model.dart';
import 'package:flutter/material.dart';


class SearchUserTitle extends StatelessWidget {
  final UserModel userModel;

  SearchUserTitle({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userModel.imgUrl),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userModel.displayName,style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6a515e),
                  ),),
                  Text(userModel.email,style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff6a515e)
                  ),)
                ],
              ))
        ],
      ),
    );
  }
}
