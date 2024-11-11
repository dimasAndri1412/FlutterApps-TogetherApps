import 'dart:convert';
import 'package:absent_project/MapsViews/MatterialMaps/FindProjectControllers.dart';
import 'package:absent_project/MapsViews/modelMaps/newLocationProjectModels.dart' as newProjectsModels;
import 'package:absent_project/MapsViews/modelMaps/usernameModel.dart' as projectsModels;
import 'package:http/http.dart' as http;

class findNewProjectsControllers {

  String? projectsNamesLocations, locationProjectsNames;
  var newProjectUsers;

  Future findLocationsNamesNew() async {
    final findProjectsId = findsProjectController();
    await findProjectsId.findUsers();

    String? projectIdValues = projectsModels.projectModel;

    try{

      var GetIdPorjects = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findNewProjectId.php");
      var getIdResp = await http.post(
        GetIdPorjects,
        body: {
           'project_id' : projectIdValues
        }
      );

      newProjectUsers = jsonDecode(getIdResp.body);
      newProjectsModels.locationNamesProjects = newProjectUsers[0]['location_name'];
      newProjectsModels.projectNamesLocations = newProjectUsers[0]['project_name'];

    } catch(errs) {
      print(errs);
    }

  }

}