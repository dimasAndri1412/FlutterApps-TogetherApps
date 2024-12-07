import 'dart:convert';

import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;
import 'package:absent_project/MapsViews/modelMaps/validateModels.dart' as validationModels;

class VerifyPasswordValue {
  
  String? passwordValue;
  var passwordUsers;

  Future verifyPassowrd() async {

    String passwordInputs = NewPasswordContorller.text;
    String userNameInputs = emailController.text;

    try{

      var getPassword = Uri.parse("http://192.168.2.159:8080/FlutterAPI/verifyPassword.php");
      var respPassword = await http.post(
          getPassword,
          body: {
            'USERNAME' : userNameInputs,
            'PASSWORD' : passwordInputs
          }
      );
      passwordUsers = jsonDecode(respPassword.body);
      validationModels.validatePassword = passwordUsers[0]['PASSWORD'];
      validationModels.validateUserNames = passwordUsers[0]['USERNAME'];

      print('Reslut : $passwordUsers');
      print('Password : ${validationModels.validatePassword}');
      print('UserName : ${validationModels.validateUserNames}');

    } catch(errors) {
      print(errors);
    }
  }
}