import 'package:absent_project/OTPVerfication/EmailPageOTP/OTPEmailButtons.dart';
import 'package:absent_project/OTPVerfication/EmailPageOTP/OTPEmailField.dart';
import 'package:flutter/material.dart';

class OTPEmailWrapper extends StatefulWidget {
  const OTPEmailWrapper({super.key});

  @override
  State<OTPEmailWrapper> createState() => _OTPEmailWrapperState();
}

class _OTPEmailWrapperState extends State<OTPEmailWrapper> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(60),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(70)
            ),
            child: SingleChildScrollView(
              child: OTPEmailPage(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          OTPEmailButtons()

        ],
      ),
    );
  }
}
