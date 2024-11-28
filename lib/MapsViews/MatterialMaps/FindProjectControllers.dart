import 'dart:convert';
import 'package:absent_project/MapsViews/modelMaps/usernameModel.dart' as projectsModels;
import 'package:http/http.dart' as http;
import '../../controller/Keys.dart';

class findsProjectController {

  String? usersNames, fullNames, projectGroup, avatarURL, companyID;
  var projectUsers;

  Future findUsers() async {

    String usersInputs = emailController.text;
    //String userNamesInputs = 'septian';

    try {

      var getUserNames = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findUserNames.php");
      var resps = await http.post(
        getUserNames,
        body: {
          'USERNAME' : usersInputs
        }
      );
      projectUsers = jsonDecode(resps.body);
      projectsModels.idUsersModels = projectUsers[0]['id'];
      projectsModels.projectModel = projectUsers[0]['project_id'];
      projectsModels.fullNameModel = projectUsers[0]['full_name'];
      projectsModels.usersModels = projectUsers[0]['USERNAME'];
      projectsModels.avatarModel = projectUsers[0]['image_path'];
      projectsModels.companyIdModel = projectUsers[0]['company_id'];
      projectsModels.positionIdModel = projectUsers[0]['position_id'];

    } catch(errs) {
      return "Can Not Find The Project";
    }
  }
}