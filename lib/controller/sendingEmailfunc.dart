import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../controller/Keys.dart';
import '../controller/projectListContoller.dart';

class sendingEmail extends StatelessWidget {
  const sendingEmail({super.key});

  Future<void> sendingEmailFunc() async{
    try{
      var userEmail = AdminEmail;
      final smptServer = gmail(userEmail, TokenAcces2);

      for (var sendController in revampResgistControllerss){
        final revampBody = revampValueBodyEmails(sendController);
        final messages = Message()
          ..from = Address(userEmail)
          ..recipients.add(sendController["revampEmailController"]?.text)
          ..subject = "ATTENTION YOU DEFAULT PASSWORD AND PLEASE CHANGES DEFAULT PASSWORD NOW!"
          ..text = revampBody;

        final sendReport = await send(messages, smptServer);
        print("Email Succes sent!!");
      }

    }catch(err) {
      print("error \n $err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
