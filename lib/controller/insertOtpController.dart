import 'dart:convert';
import 'package:absent_project/Registration/Functions/functionOTPKey.dart';
import 'package:absent_project/controller/FindOTPController.dart';
import '../controller/projectListContoller.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/sendingEmailOTP.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class insertOtpController {

  String? emailAddress,otpCodes;
  var otpUser;

  Future insertOTPCode() async {
    String otpInputs = functionOTPKey.GeneratedOTP();
    String emailInputs = EmailController.text;

    try{

      var otpUrl = Uri.parse("http://192.168.2.159/FlutterAPI/insertOTP.php");
      var resp = await http.post(
          otpUrl,
          body: {
            'email_address' : emailInputs,
            'otp_code' : otpInputs
          }
      );
      otpUser = jsonDecode(resp.body);

    } catch (excetion) {
      return "can not insert OTP!";
    }
  }
}