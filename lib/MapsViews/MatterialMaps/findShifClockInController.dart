import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/MapsViews/modelMaps/clockOutModels.dart' as clockOutModels;
import 'package:http/http.dart' as http;

class findClockOutControllers {

  String? fullNames,usersNames,projectsNames,locationClockIn,shifClockIn,ClockInTimes;
  var clockInUsers;

  Future findClockInValues() async {

    String userInputs = emailController.text;

    try {

      var getClockIn = Uri.parse("http://192.168.100.249/FlutterAPI/findValueClockIn.php");
      var getresp = await http.post(
          getClockIn,
          body: {
            'user_name' : userInputs
          }
      );

      clockInUsers = jsonDecode(getresp.body);
      //clockOutModels.fullNamesCLockOutModels = clockInUsers[0]['full_names'];
      clockOutModels.userNamesCLockOutModels = clockInUsers[0]['user_name'];
      clockOutModels.ClockInTimeCLockOutModels = clockInUsers[0]['clock_in'];
      clockOutModels.shiftCLockOutModels = clockInUsers[0]['shift'];

    } catch (errs) {
      return "Can not find clock in values";
    }
  }
}