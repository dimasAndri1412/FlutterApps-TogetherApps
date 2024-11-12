import 'dart:convert';
import 'package:absent_project/MapsViews/MatterialMaps/FindProjectControllers.dart';
import 'package:http/http.dart' as http;
import 'package:absent_project/controller/Models/imagePathModels.dart' as imagesModels;
import 'package:absent_project/MapsViews/modelMaps/usernameModel.dart' as projectsModels;

class findImageController {

  String? emailAddress,otpCodes;
  var dataUsers;

  Future findImages() async{

    final findsProjectController userControllers = findsProjectController();
    await userControllers.findUsers();

    String? IdInputs = projectsModels.idUsersModels;

    try{

      var findAPI = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findImagePath.php");
      var resp = await http.post(
          findAPI,
          body: {
            'user_id' : IdInputs
          }
      );

      dataUsers = jsonDecode(resp.body);
      imagesModels.impagesPath = dataUsers[0]['image_path'];
      print(IdInputs);


    } catch(exception) {
      return "Can not find images";
    }
  }
}