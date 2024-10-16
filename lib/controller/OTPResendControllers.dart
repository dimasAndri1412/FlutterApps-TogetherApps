import 'dart:convert';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/controller/deleteOldOTPController.dart';
import 'package:absent_project/controller/insertOTPController.dart';
import 'package:absent_project/controller/sendingEmailOTP.dart';
import '../controller/Keys.dart';
import 'package:http/http.dart' as http;

class otpResendControllers {

  String? emailAddres;
  var EmailUser;


  Future ResendOtpCode() async {

    String EmailInputs = EmailController.text;

    try{

      var GetEmail = Uri.parse("http://192.168.2.159:8080/FlutterAPI/FindEmail.php");
      var response = await http.post(
          GetEmail,
          body: {
            'email_address': EmailInputs
          }
      );
      EmailUser = jsonDecode(response.body);
      emailAddres = EmailUser[0]['email_address'];

      final deleteOTP = await deleteOTPControllers().DeleteOTPCode();
      final insertOTP = await insertOtpController().insertOTPCode();
      final sendOTP = await sendingEmailOTP().sendingEmailOTPFuc();

      if (EmailController.text == emailAddres) {
        deleteOTP;
        insertOTP;
        sendOTP;

      } else {
        ctr_data().clear_func();
        return "Email is not match";
      }

    } catch (Exception) {
      return "Failed Send OTP";
    }
  }
}