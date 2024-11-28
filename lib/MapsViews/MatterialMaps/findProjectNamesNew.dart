import 'dart:convert';

import 'package:absent_project/MapsViews/MatterialMaps/FindProjectControllers.dart';
import 'package:absent_project/MapsViews/modelMaps/usernameModel.dart' as projectsModels;
import 'package:http/http.dart' as http;

class FindProjectNamesControllers {
  
  String? projectID,projectNames;
  var projectNameUsers;
  
  Future findProjectNameNews() async{
    
    final findsProjectController projectIDs = findsProjectController();
    await projectIDs.findUsers();
    
    String? projectIDinputs = projectsModels.projectModel;
   
    try{
      
      var getProjectName = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findProjectNamesNew.php");
      var projectNameRsp = await http.post(
        getProjectName,
        body: {
          'id' : projectIDinputs
        }
      );

      projectNameUsers = jsonDecode(projectNameRsp.body);
      projectsModels.projectNames = projectNameUsers[0]['project_name'];
      
    }catch(errs) {
      print("errors message : $errs");
    }
    
  }
}