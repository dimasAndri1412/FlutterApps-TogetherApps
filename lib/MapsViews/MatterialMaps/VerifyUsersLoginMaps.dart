import 'dart:convert';
import 'package:absent_project/home/ApplicationBar.dart';
import 'package:absent_project/home/ApplicationBarClockInUsers.dart';
import 'package:absent_project/home/applicationbar_user.dart';
import 'package:get/get.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/home/ApplicationBarClockIn.dart';
import 'package:http/http.dart' as http;

class verifyRolesClockIn {

  String? rolesClockIn;
  var dataUsers;

  Future verifyRolesUsersClockIn() async{

    String userNameInputs = emailController.text;

    try {

      var verifyAPI = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findRoles.php");
      var resp = await http.post(

          verifyAPI,
          body: {
            'USERNAME' : userNameInputs
          }
      );

      dataUsers = jsonDecode(resp.body);
      rolesClockIn = dataUsers[0]['ROLE'];

      print('ROLES : $rolesClockIn');

      if(rolesClockIn == 'ADMIN') {
        Get.to(ApplicationBar());
      } else {
        Get.to(ApplicationBarUser());
      }


    } catch (err) {
      return "OTP Code it's not match!";
    }
  }
}