import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../home/ApplicationBar.dart';

class LoginController{
  String? alert, username, password, role;

  var dataUser;

  Future doLogin() async {
    String usernameInput = emailController.text;
    String passwordInput = passwordController.text;

    try{
      if (formKey.currentState!.validate()) {
        var url = Uri.parse("http://192.168.2.159/FlutterAPI/AdminLogin.php");
        var response = await http.post(url, body: {
          "username": usernameInput,
          "password": passwordInput
        });
        dataUser = jsonDecode(response.body);

        if (dataUser.length < 1) {
            alert = "Can't login";
        } else {
            username = dataUser[0]['USERNAME'];
            password = dataUser[0]['PASSWORD'];
            role = dataUser[0]['ROLE'];
          };

          if (role == "admin") {
            Get.to(() => const ApplicationBar());
          } else {
            print("Go to member home page, cuk");
            /*Get.to(() => const UserHome());*/
          }
        }
    }catch(Exception){
      return "Failed Request!";}
  }
}

