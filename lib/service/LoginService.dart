import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import '../controller/Keys.dart';
import 'package:http/http.dart' as http;

import '../home/bar.dart';

class LoginService {
  String email = emailController.text;
  String password = passwordController.text;

  Future <bool> loginAdmin() async {
    try{
      var url = Uri.parse("http://192.168.100.214/FlutterAPI/AdminLogin.php");
      var response = await http.post(url, body: {
        "username": email,
        "password": password
      });
      var data = jsonDecode(response.body);
      if (data == "Success") {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const BottomBar()),);
        Get.offAll(const BottomBar());
      } else {
        print("Error cuk");
      }return true;
    }on Exception catch(err){
      return false;

    }
  }
}