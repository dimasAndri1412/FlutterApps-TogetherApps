import 'dart:convert';

import 'package:absent_project/MapsViews/MatterialMaps/FindProjectControllers.dart';
import 'package:absent_project/MapsViews/modelMaps/usernameModel.dart' as projectsModels;
import 'package:http/http.dart' as http;

class findPositionControllers {

  String? positionId,positionNames;
  var positionUsers;

  Future findPositionNames() async {
    final findsProjectController positionID = findsProjectController();
    await positionID.findUsers();

    String? positionIdInputs = projectsModels.positionIdModel;

    try{

      var getPositionName = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findPositionNames.php");
      var positionNameResp = await http.post(
        getPositionName,
        body: {
          'id' : positionIdInputs
        }
      );

      positionUsers = jsonDecode(positionNameResp.body);
      projectsModels.positionNames = positionUsers[0]['position_name'];

    } catch(errs) {
      print("errors : $errs");
    }
  }
}