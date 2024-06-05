import 'dart:convert';
import 'package:absent_project/OTPVerfication/OTPCodePage/OTPCodePages.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/controller/insertOTPController.dart';
import 'package:absent_project/controller/sendingEmailOTP.dart';
import 'package:get/get.dart';

import '../controller/Keys.dart';
import 'package:http/http.dart' as http;

class OtpControllers {

  String? emailAddres;
  var EmailUser;


  Future SendOtpCode() async {

    String EmailInputs = EmailController.text;

    try{

      var GetEmail = Uri.parse("http://192.168.2.159/FlutterAPI/FindEmail.php");
      var response = await http.post(
          GetEmail,
          body: {
            'email_address': EmailInputs
          }
      );
      EmailUser = jsonDecode(response.body);
      emailAddres = EmailUser[0]['email_address'];

      final insertOTP = await insertOtpController().insertOTPCode();
      final sendOTP = await sendingEmailOTP().sendingEmailOTPFuc();

      if (EmailController.text == emailAddres) {
        insertOTP;
        sendOTP;
        Get.offAll(() => OTPCodePages());
        ctr_data().clear_func();
      } else {
        ctr_data().clear_func();
        return "Email is not match";
      }

    } catch (Exception) {
      return "Failed Send OTP";
    }
  }
}