import 'dart:async';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/OTPResendControllers.dart';
import 'package:flutter/material.dart';

class revampOTPResendButtons extends StatefulWidget {
  const revampOTPResendButtons({super.key});

  @override
  State<revampOTPResendButtons> createState() => _revampOTPResendButtonsState();
}

class _revampOTPResendButtonsState extends State<revampOTPResendButtons> {

  int secondsRemainings = 90;
  bool enabledResend = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startCountDown();
  }

  void startCountDown() {
    enabledResend = false;
    secondsRemainings = 90;
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (secondsRemainings > 0) {
        setState(() {
          secondsRemainings--;
        });
      } else {
        setState(() {
          enabledResend = true;
          timer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTimes(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2,'0')}';
  }

  @override
  Widget build(BuildContext context) {

    String emails = EmailController.text;
    var nameUsers = emails.split("@");
    var emailChars = emails.replaceRange(2, nameUsers[0].length, "*" * (nameUsers[0].length - 2));
    String emaisValues = emailChars;

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: enabledResend ? () {
            startCountDown();
            otpResendControllers().ResendOtpCode();
          } : null,
          child: Container(
              height: 50,
              width: 300,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  enabledResend
                  ? 'RESEND TO $emaisValues'
                  : 'RESEND IN ${formatTimes(secondsRemainings)}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),

                ),
              )
          ),
        )
      ],
    );
  }
}
