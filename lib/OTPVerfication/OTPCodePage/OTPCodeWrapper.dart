import 'package:absent_project/OTPVerfication/OTPCodePage/OTPCodeButtons.dart';
import 'package:absent_project/OTPVerfication/OTPCodePage/OTPCodeField.dart';
import 'package:flutter/material.dart';

class OTPCodeWrapper extends StatefulWidget {
  const OTPCodeWrapper({super.key});

  @override
  State<OTPCodeWrapper> createState() => _OTPCodeWrapperState();
}

class _OTPCodeWrapperState extends State<OTPCodeWrapper> {
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
              child: OTPCodeField(),
            ),
          ),
          SizedBox(
            height: 30,
          ),

          OTPCodeButtons()

        ],
      ),
    );
  }
}
