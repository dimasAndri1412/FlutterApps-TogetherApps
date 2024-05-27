import 'package:flutter/material.dart';

class forgotPasswordHeader extends StatelessWidget {
  const forgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset("assets/images/forgot-account-password.png",
              width: 250,),
          )
        ],
      ),
    );
  }
}
