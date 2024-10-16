import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/OTPController.dart';
import 'Models/otpModels.dart' as otpmodel;
import 'Models/emailModel.dart' as emailmodel ;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class findOTPController {

  String? emailAddress,otpCodes;
  var dataUsers;

  Future findOtps() async{

    String EmailsInputs = EmailController.text;
    
    try{
     
      var findAPI = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findOTP.php");
      var resp = await http.post(
        findAPI,
        body: {
            'email_address' : EmailsInputs
        }
      );

      dataUsers = jsonDecode(resp.body);
      otpmodel.otpcodes = dataUsers[0]['otp_code'];
      emailmodel.emailAddres = dataUsers[0]['email_address'];

      if (EmailsInputs == emailmodel.emailAddres) {
        print("otp sent succes ${otpmodel.otpcodes}");
      }

    } catch(exception) {
      return "Can not find otp code";
    }
  }
}