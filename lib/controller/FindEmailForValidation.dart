import 'dart:convert';

import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;
import 'package:absent_project/controller/Models/validationModels.dart' as validationValues;

class findEmailControllers {

  String? emailNames;
  var userEmailsValues;

  Future validationEmails() async {

    String emailValuesInput = EmailController.text;

    try{

      var findEmail = Uri.parse("http://192.168.2.159:8080/FlutterAPI/FindEmail.php");
      var userRsp = await http.post(
        findEmail,
        body: {
              'email_address' : emailValuesInput
        }
      );

      userEmailsValues = jsonDecode(userRsp.body);
      validationValues.validationEmails = userEmailsValues[0]['email_address'];

    } catch (Exception) {
      return "coul not find email address";
    }

  }
}