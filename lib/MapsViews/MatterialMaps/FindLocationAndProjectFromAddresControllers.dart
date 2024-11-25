import 'dart:convert';
import 'package:absent_project/MapsViews/MatterialMaps/FindProjectControllers.dart';
import 'package:absent_project/MapsViews/modelMaps/newProjectModels.dart' as projectsLocModel;
import 'package:absent_project/MapsViews/modelMaps/usernameModel.dart' as projectsModels;
import 'package:http/http.dart' as http;

class findLocAndProControllers {

  String? usersNames, fullNames, projectGroup, avatarURL,
          proNames,locNames;
  var locProUsers;

  Future<List<projectsLocModel.newProjecModels>> findProLocations() async {
    final findsProjectController findsUsr = findsProjectController();
    findsUsr.findUsers();

    try {

      //String? projectNamesInputs = "Manage Service Data Operation (MSDO)";
      String? projectId = projectsModels.projectModel;
      //String? idTest = "60";

      var getProNames = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findNewProjectId.php");
      var resPro = await http.post(
          getProNames,
          body: {
            'project_id': projectId
          }
      );

      // Parsing JSON response as List
      List<dynamic> jsonResponse = jsonDecode(resPro.body);
      List<projectsLocModel.newProjecModels> locProUsersList = projectsLocModel.newProjecModels.fromJsonList(jsonResponse);

      return locProUsersList;

    } catch (errs) {
      print(errs);
      throw Exception("Error retrieving project locations");
    }
  }
}