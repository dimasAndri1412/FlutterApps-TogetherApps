import 'package:flutter/material.dart';

class ChangesPasswordHeader extends StatelessWidget{

  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset("assets/images/Changes_Passwords.png",
              width: 165,),
          )
        ],
      ),
    );
  }
}