import 'dart:convert';
import 'package:absent_project/MapsViews/MatterialMaps/FindMapLocationControllers.dart';
import 'package:absent_project/MapsViews/modelMaps/usernameModel.dart' as projectsModels;
import 'package:http/http.dart' as http;
import '../../controller/Keys.dart';

class findsProjectController {

  String? usersNames, fullNames, projectGroup, avatarURL;
  var projectUsers;

  Future findUsers() async {

    String usersInputs = emailController.text;
    String userNames = 'dimas';

    try {

      var getUserNames = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findUserNames.php");
      var resps = await http.post(
        getUserNames,
        body: {
          'USERNAME' : usersInputs
        }
      );
      projectUsers = jsonDecode(resps.body);
      projectsModels.projectModel = projectUsers[0]['project_id'];
      projectsModels.fullNameModel = projectUsers[0]['full_name'];
      projectsModels.usersModels = projectUsers[0]['USERNAME'];
      projectsModels.avatarModel = projectUsers[0]['image_path'];

      final findCoordinate = await findGmapsLocation();

    } catch(errs) {
      return "Can Not Find The Project";
    }
  }
}