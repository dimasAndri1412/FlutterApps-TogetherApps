import 'dart:convert';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/controller/insertOTPController.dart';
import 'package:absent_project/controller/sendingEmailOTP.dart';
import '../controller/Keys.dart';
import 'package:http/http.dart' as http;

class deleteOTPControllers {

  String? emailAddres;
  var EmailUser;


  Future DeleteOTPCode() async {

    String EmailInputs = EmailController.text;

    try{

      var GetEmail = Uri.parse("http://192.168.2.159:8080/FlutterAPI/deleteOldOTP.php");
      var response = await http.post(
          GetEmail,
          body: {
            'email_address': EmailInputs
          }
      );
      EmailUser = jsonDecode(response.body);
      emailAddres = EmailUser[0]['email_address'];

    } catch (Exception) {
      return "Failed Send OTP";
    }
  }
}