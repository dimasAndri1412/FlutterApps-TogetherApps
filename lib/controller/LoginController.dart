import 'dart:convert';
import 'package:absent_project/ChangesPasswordPage/ChangesPasswordMenu.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../home/ApplicationBar.dart';

class LoginController {
  String? alert, username, password, role, login_flag;

  var dataUser;

  Future doLogin() async {
    String usernameInput = emailController.text;
    String passwordInput = passwordController.text;

    try {
      if (formKey.currentState!.validate()) {
        var url = Uri.parse("http://192.168.2.159/FlutterAPI/AdminLogin.php");
        var response = await http.post(url,
            body: {"username": usernameInput, "password": passwordInput});
        dataUser = jsonDecode(response.body);

        if (dataUser.length < 1) {
          alert = "Can't login";
        } else {
          username = dataUser[0]['USERNAME'];
          password = dataUser[0]['PASSWORD'];
          role = dataUser[0]['ROLE'];
          login_flag = dataUser[0]['login_flag'];
        }
        ;

        if (login_flag == "0" && role == "MEMBER") {
          Get.offAll(() => const ChangesPasswordMenu());
        } else if (login_flag == "1" && role == "MEMBER") {
          print("kamu itu member");
          /*Get.to(() => const UserHome());*/
        } else if (role == "ADMIN") {
          Get.offAll(() => const ApplicationBar());
        } else {
          print("Go to member home page, cuk");
          /*Get.to(() => const UserHome());*/
        }

        /*  if (role == "admin") {
          Get.offAll(() => const ApplicationBar());
        } else {
          print("Go to member home page, cuk");
          */ /*Get.to(() => const UserHome());*/ /*
        }*/
      }
    } catch (Exception) {
      return "Failed Request!";
    }
  }
}
