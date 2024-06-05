import 'package:flutter/material.dart';
import 'Keys.dart';
import 'projectListContoller.dart';
import 'package:mailer/mailer.dart';
import '../controller/FindOTPController.dart';
import 'package:mailer/smtp_server/gmail.dart';

class sendingEmailOTP extends StatelessWidget {
  const sendingEmailOTP({super.key});

  Future<void> sendingEmailOTPFuc() async{

    try{

      var userEmail = AdminEmail;

      final smptServer = gmail(userEmail, TokenAcces2);

      final otpMessages = await sendOTPtoEmail();

      final messages = Message()
        ..from = Address(userEmail)
        ..recipients.add(EmailController.text)
        ..subject = "ATTENTION YOU OTP CODE IS ARRIVED!"
        ..text = otpMessages;

      final sendReport = await send(messages, smptServer);
      print("Email Succes sent!!");

    }catch(err) {
      print("error \n $err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
