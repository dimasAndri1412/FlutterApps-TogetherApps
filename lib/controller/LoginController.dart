import 'dart:convert';
import 'package:absent_project/ChangesPasswordPage/ChangesPasswordMenu.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../home/ApplicationBar.dart';
import '../home/applicationbar_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  String? alert, username, password, role, login_flag, IDUsers, position;

  var dataUser;

  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userId);
  }

  Future doLogin() async {
    String usernameInput = emailController.text;
    String passwordInput = passwordController.text;

    try {
      if (formKey.currentState!.validate()) {
        var url = Uri.parse("http://10.233.124.109/FlutterAPI/AdminLogin.php");
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
          IDUsers = dataUser[0]['ID'];
          position = dataUser[0]['ID'];
        };

         await saveUserId(IDUsers!);

        if (login_flag == "0" && role == "MEMBER" && IDUsers == IDUsers ) {
          Get.offAll(() => const ChangesPasswordMenu());
        } else if (login_flag == "1" && role == "MEMBER" && IDUsers == IDUsers) {
          Get.offAll(() => const ApplicationBarUser());
          print("kamu itu member dengan ID = ${IDUsers}");
          /*Get.to(() => const UserHome());*/
        } else if (role == "ADMIN") {
          Get.offAll(() => const ApplicationBar());
        } else if (role == "ADMIN" && position == "Manager") {
          Get.offAll(() => const ApplicationBar());
        }else {
          print("Go to member home page, cuk dengan id = ${IDUsers}");
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
