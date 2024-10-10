import 'dart:convert';
import 'package:absent_project/MapsViews/modelMaps/lastLogOutsModels.dart' as lastClockOutModel;
import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;

class findLastLogOutControllers {

  String? userNames,locationProjectNames,lastLogOuts;
  var lastLogOutUsers;

  Future findLogOuts() async{

    String usernameInputs = emailController.text;

    try{

      var getlastLogOut = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findLastLogin.php");
      var getresp = await http.post(
          getlastLogOut,
          body: {
            'user_name' : usernameInputs
          }
      );

      lastLogOutUsers = jsonDecode(getresp.body);
      lastClockOutModel.lastClockOuts = lastLogOutUsers[0]['clock_out'];
      lastClockOutModel.locationLastClockOuts = lastLogOutUsers[0]['location'];

    } catch (err) {
      return "can not find location";
    }
  }
}