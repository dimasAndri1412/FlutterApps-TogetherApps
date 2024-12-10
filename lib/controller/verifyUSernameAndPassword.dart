import 'dart:convert';

import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;
import 'package:absent_project/MapsViews/modelMaps/validateModels.dart' as validationModelsss;

class VerfiedUserNameAndPassword {

  String? userNamesVerified,passwordVerified;
  var verifiedUsers;

  Future verifyEmailPass() async {

    try{

      String userNamesInputs = emailController.text;
      String passwordInputs = passwordController.text;

      var getUserNamePass = Uri.parse("http://192.168.2.159:8080/FlutterAPI/verifyUserNamesPassword.php");
      var verifyResp = await http.post(

          getUserNamePass,
          body: {
            'USERNAME' : userNamesInputs,
            'PASSWORD' : passwordInputs
          }
      );

      verifiedUsers = jsonDecode(verifyResp.body);
      validationModelsss.validateUserNames = verifiedUsers[0]['USERNAME'];
      validationModelsss.validatePassword = verifiedUsers[0]['PASSWORD'];

    }catch(errs) {
      print(errs);
    }
  }
}