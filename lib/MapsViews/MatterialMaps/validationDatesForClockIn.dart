import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;
import 'package:absent_project/MapsViews/modelMaps/validateModels.dart' as validationModels;

class verifyDateClockIn {

  String? dateClockIn;
  var dataUsers;

  Future verifyClockIn() async{

    String userNameInputs = emailController.text;

    try {

      var verifyAPI = Uri.parse("http://192.168.2.159:8080/FlutterAPI/verifyDates.php");
      var resp = await http.post(

          verifyAPI,
          body: {
            'user_name' : userNameInputs
          }
      );

      dataUsers = jsonDecode(resp.body);
      validationModels.validateClockInModels = dataUsers[0]['clock_in'];


    } catch (err) {
      return "OTP Code it's not match!";
    }
  }
}