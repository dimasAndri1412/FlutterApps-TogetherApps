import 'package:flutter/material.dart';

class OTPCodeHeaders extends StatelessWidget {
  const OTPCodeHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset("assets/images/otp_verfication.png",
              width: 190,),

          )
        ],
      ),
    );
  }
}

