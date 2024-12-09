import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;
import 'package:absent_project/MapsViews/modelMaps/validasiModelPassword.dart' as passwordModels;

class VerifyPasswordValue {
  
  String? passwordValue;
  var passwordUsers;

  Future verifyPassowrd() async {

    String passwordInputs = NewPasswordContorller.text;

    try{

      var getPassword = Uri.parse("http://192.168.2.159:8080/FlutterAPI/verifyPassword.php");
      var respPassword = await http.post(
          getPassword,
          body: {
            'PASSWORD' : passwordInputs,
          }
      );
      passwordUsers = jsonDecode(respPassword.body);
      passwordModels.validatePasswords = passwordUsers[0]['PASSWORD'];

      print('Password : ${passwordModels.validatePasswords}');

    } catch(errors) {
      print(errors);
    }
  }
}