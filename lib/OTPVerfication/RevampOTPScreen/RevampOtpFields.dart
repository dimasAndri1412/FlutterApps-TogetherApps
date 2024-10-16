import 'dart:async';
import 'package:absent_project/OTPVerfication/RevampOTPScreen/RevampOtpButton.dart';
import 'package:absent_project/OTPVerfication/RevampOTPScreen/RevampOtpResendOtpButtons.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class revampOTPField extends StatefulWidget {
  const revampOTPField({super.key});

  @override
  State<revampOTPField> createState() => _revampOTPFieldState();
}

class _revampOTPFieldState extends State<revampOTPField> {

  @override
  Widget build(BuildContext context) {

    String emails = EmailController.text;
    var nameUsers = emails.split("@");
    var emailChars = emails.replaceRange(2, nameUsers[0].length, "*" * (nameUsers[0].length - 2));
    String emaisValues = emailChars;

    final basicPinPutThemes = PinTheme(
      width: 56,
      height: 60,
      textStyle: TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: Colors.transparent
        ),
      ),
    );

    return Column(
      children: <Widget>[
        Container(
          child: Form(
            key: revampOTPScreenKey,
            child: Column(
              children: [
                const Text(
                  'VERIFICATION',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin:  EdgeInsets.symmetric(
                      vertical: 40
                  ),
                  child: Text(
                    'Please Enter the conde sent to your email $emaisValues',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Pinput(
                  length: 6,
                  controller: revampOTPControllers,
                  defaultPinTheme: basicPinPutThemes,
                  focusedPinTheme: basicPinPutThemes.copyWith(
                      decoration: basicPinPutThemes.decoration!.copyWith(
                          border: Border.all(
                              color: Colors.blueAccent
                          )
                      )
                  ),
                  validator: (values) {
                    if (values == null || values.isEmpty) {
                      return 'Please Insert you OTP Code!';
                    }
                  } ,
                ),
                SizedBox(
                  height: 30,
                ),
                revampOTPButtons(),
                SizedBox(
                  height: 30,
                ),
                revampOTPResendButtons()
              ],
            ),
          ),
        )
      ],
    );
  }
}
