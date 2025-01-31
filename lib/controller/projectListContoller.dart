import 'package:flutter/material.dart';
import 'package:absent_project/controller/FindEmailForValidation.dart';
import 'package:absent_project/controller/FindOTPController.dart';
import 'package:absent_project/controller/findImagePath.dart';
import 'Models/otpModels.dart' as otpmodel;
import 'Models/emailModel.dart' as emailmodel ;
import 'package:absent_project/controller/Models/validationModels.dart' as validationValues;
import 'package:absent_project/controller/Models/imagePathModels.dart' as imagesModels;
import 'Keys.dart';

final String TokenAcces2 = "owvl tynj qlqb inyv";

final String AdminEmail = "absentsnotif@gmail.com";

String valueBodyEmail() {
  String emailContent = "";
  for (var bodyController in revampResgistControllerss) {
    emailContent +=
    "HI, ${bodyController["revampFullNameController"]?.text}\n"
        "\n"
        "YOUR GOT DEFAULT USER :\n"
        "==============================\n"
        "USERNAME : ${bodyController["revampUserNameController"]?.text}\n"
        "PASSWORD : ${bodyController["revampPasswordController"]?.text}\n"
        "==============================\n"
        "\n"
        "PLEASE CHANGE THE DEFAULT PASSWORD WITH THE PASSWORD!\n"
        "THAT YOU WANT, AND IT'S EASY TO REMEMBER.\n"
        "AND TRY TO LOGIN WITH THE PASSWORD THAT HAS BEEN CHANGED.\n"
        "\n"
        "Thank you\n"
        "\n"
        "Best Regard\n"
        "ADMIN\n\n";
  }
  return emailContent;
}

final String bodyEmails = valueBodyEmail();

//revampBodyEmail
String revampValueBodyEmails(Map<String, TextEditingController> bodyEmailController){
  return "HI, ${bodyEmailController["revampFullNameController"]?.text}\n"
      "\n"
      "YOUR GOT DEFAULT USER :\n"
      "==============================\n"
      "USERNAME : ${bodyEmailController["revampUserNameController"]?.text}\n"
      "PASSWORD : ${bodyEmailController["revampPasswordController"]?.text}\n"
      "==============================\n"
      "\n"
      "PLEASE CHANGE THE DEFAULT PASSWORD WITH THE PASSWORD!\n"
      "THAT YOU WANT, AND IT'S EASY TO REMEMBER.\n"
      "AND TRY TO LOGIN WITH THE PASSWORD THAT HAS BEEN CHANGED.\n"
      "\n"
      "Thank you\n"
      "\n"
      "Best Regard\n"
      "ADMIN\n\n";
}


final String bodyEmailsForgots =
    "HI,${FullNameController.text}\n"
                          "\n"
                          "YOUR PASSWORD HAS CHANGES :"
                          "\n"
                          "================================\n"
                          "NEW PASSWORD : ${NewPasswordContorller.text}\n"
                          "================================\n"
                          "\n"
                          "FOR NEXT LOGIN USE NEW PASSWORD\n"
                          "\n"
                          "\n"
                          "Thanks you\n"
                          "\n"
                          "Best Regard\n"
                          "ADMIN";


//bodyemailOTP
Future<String> sendOTPtoEmail() async{
  final findOTPController otpController = findOTPController();

  await otpController.findOtps();

  final String bodiesEmailsOTP =
      "HI,${FullNameController.text}\n"
      "\n"
      "YOUR OTP CODE :"
      "\n"
      "================================\n"
      "OTPCODE : ${otpmodel.otpcodes}\n"
      "================================\n"
      "\n"
      "PLEASE INSERT OTP CODE TO NEXT STEP\n"
      "\n"
      "\n"
      "Thanks you\n"
      "\n"
      "Best Regard\n"
      "ADMIN";

  return bodiesEmailsOTP;
}

//getting email
Future<String?> sendEmail()  async {
  final findOTPController otpController = findOTPController();
  await otpController.findOtps();

  String? sendingEmail = emailmodel.emailAddres;

  final String? valueEmail =  sendingEmail;

  return valueEmail;
}


//getting otp
Future<String?> sendOTPCode()  async {
  final findOTPController otpController = findOTPController();
  await otpController.findOtps();

  String? sendOTPCode = otpmodel.otpcodes;

  final String? valueOTP =  sendOTPCode;

  return valueOTP;
}

Future<String?> validationUserEmails() async{
  final findEmailControllers findUserEmailController = findEmailControllers();
  await findUserEmailController.validationEmails();

  String? userEmailValues = validationValues.validationEmails;

  final String? emailSValues = userEmailValues;

  return emailSValues;

}

Future<String?> getImagePath() async {
  final findImageController findImagesPaths = findImageController();
  await findImagesPaths.findImages();

  String? imagesValues = imagesModels.impagesPath;

  final String? imagesPathss = imagesValues;

  print(imagesValues);

  return imagesPathss;
}
 

