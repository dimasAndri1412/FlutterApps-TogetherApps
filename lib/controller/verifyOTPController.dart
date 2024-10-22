import 'dart:convert';
import 'package:absent_project/ForgotPassword/forgotPasswordMenu.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/controller/deleteOldOTPController.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class verifyOTPController {
  
  String? otpCodes;
  var dataUsers;
  
  Future verifyOTP() async{
    
    String otpInputs = revampOTPControllers.text;
    
    try {
     
      var verifyAPI = Uri.parse("http://192.168.2.159:8080/FlutterAPI/verifyOTP.php");
      var resp = await http.post(

        verifyAPI,
        body: {
          'otp_code' : otpInputs
        }
      );

      dataUsers = jsonDecode(resp.body);
      otpCodes = dataUsers[0]['otp_code'];

      final deleteOTP = await deleteOTPControllers().DeleteOTPCode();

      if (otpInputs == otpCodes) {
        Get.offAll(() => const forgotPasswordMenu());
        deleteOTP;
        ctr_data().clear_func_otp();
      } else {
        ctr_data().clear_func_otp();
        return "OTP Code Not match";
      }

    } catch (err) {
      return "OTP Code it's not match!";
    }
  }
}