import 'dart:convert';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/home/ApplicationBar.dart';
import 'package:absent_project/home/ApplicationBarClockInUsers.dart';
import 'package:absent_project/home/applicationbar_user.dart';
import 'package:get/get.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/home/ApplicationBarClockIn.dart';
import 'package:http/http.dart' as http;

class verifyRolesClockOut {

  String? rolesClockIn;
  var dataUsers;

  Future verifyRolesUsersClockOut() async{

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

      if (rolesClockIn == 'ADMIN') {
        Get.offAll(ApplicationBar());
        ctr_data().clear_maps_clock_in_out_func();

      } else if (rolesClockIn == 'MEMBER') {
        Get.offAll(ApplicationBarUser());
        ctr_data().clear_maps_clock_in_out_func();
      }


    } catch (err) {
      return "OTP Code it's not match!";
    }
  }
}