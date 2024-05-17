import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mailer/mailer.dart';
import '../controller/projectListContoller.dart';

class sendingEmail extends StatelessWidget {
  const sendingEmail({super.key});

  Future<void>SendingEmail() async {
    try{

      var userEmail = "dimasdrjt666@gmail.com";
      final smtpServer = gmail(userEmail, tokenAccess);

      final messages = Message()
        ..from = Address(userEmail)
        ..recipients.add("dimasandri1412@gmail.com")
        ..subject = "ATTENTION FOR YOUR CHANGES PASSWORD"
        ..text = bodyEmails;

      final sendReport = await send(messages, smtpServer);
      print("Email success sent!!");
      
    }catch (err) {
      print("error \n $err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
