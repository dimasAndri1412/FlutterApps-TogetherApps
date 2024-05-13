import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;

import '../home/ApplicationBar.dart';

class LoginController {

  Future doLogin() async {
    String email = emailController.text;
    String password = passwordController.text;

    var url = Uri.parse("http://192.168.2.159/FlutterAPI/AdminLogin.php");
    var response = await http.post(url, body: {
      "username": email,
      "password": password
    });
    var data = jsonDecode(response.body);
    if (data == "Success") {
      Get.to(() => const ApplicationBar());
    } else {
      print("Error cuk");
    }
  }
}