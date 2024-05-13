import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/home/bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// import '../home/bar.dart';
// class LoginAuth{
//   Future loginAdmin() async{
//     var url = Uri.parse("http://192.168.43.226/FlutterAPI/AdminLogin.php");
//     var response = await http.post(url, body:{
//       "username": emailController.text,
//       "password": passwordController.text,
//     });
//     var data = jsonDecode(response.body);
//     if(data == "Success") {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const BottomBar()),);
//       }
//     }
//
//   }
//
//
//   }


Future loginAdmin() async{
  var url = Uri.parse("http://192.168.100.214/FlutterAPI/AdminLogin.php");
  var response = await http.post(url, body:{
    "username": emailController.text,
    "password": passwordController.text,
  });
  var data = jsonDecode(response.body);
  if(data == "Success") {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const BottomBar()),);
    // Get.ofAll(BottomBar());
  }else{
    print ("Error cuk");
  }
}