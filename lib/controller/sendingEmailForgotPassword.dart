import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../controller/Keys.dart';
import '../controller/projectListContoller.dart';

class sendingEmailForgotPassword extends StatelessWidget {
  const sendingEmailForgotPassword({super.key});

  Future<void> sendingEmailForgotPasswordFunc() async{
    try{
      var userEmail = AdminEmail;
      final smptServer = gmail(userEmail, TokenAcces);

      final messages = Message()
        ..from = Address(userEmail)
        ..recipients.add(EmailController.text)
        ..subject = "ATTENTION YOU DEFAULT PASSWORD AND PLEASE CHANGES DEALUT PASSWORD NOW!"
        ..text = bodyEmailsForgots;

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
