import 'package:absent_project/controller/FindEmailForValidation.dart';
import 'package:absent_project/controller/FindOTPController.dart';
import 'Models/otpModels.dart' as otpmodel;
import 'Models/emailModel.dart' as emailmodel ;
import 'package:absent_project/controller/Models/validationModels.dart' as validationValues;
import 'Keys.dart';

final String TokenAcces2 = "owvl tynj qlqb inyv";

final String AdminEmail = "absentsnotif@gmail.com";

final String bodyEmails = "HI,${FullNameController.text}\n"
                          "\n"
                          "YOUR GOT DEFAULT USER :"
                          "\n"
                          "==============================\n"
                          "USERNAME : ${UserNameController.text}\n"
                          "PASSWORD : ${PassController.text}\n"
                          "==============================\n"
                          "\n"
                          "PLEASE CHANGE THE DEFAULT PASSWORD WITH THE PASSWORD!\n"
                          "THAT YOU WANT, AND IT'S EASY TO REMEMBER.\n"
                          "AND TRY TO LOGIN WITH THE PASSWORD THAT HAS BEEN CHANGED.\n"
                          "\n"
                          "\n"
                          "Thanks you\n"
                          "\n"
                          "Best Regard\n"
                          "ADMIN";

final String bodyEmailsForgots =
    "HI,${FullNameController.text}\n"
                          "\n"
                          "YOUR PASSWORD HAS CHANGES :"
                          "\n"
                          "================================\n"
                          "USERNAME : ${UserNameController.text}\n"
                          "PASSWORD : ${NewPasswordContorller.text}\n"
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



 

