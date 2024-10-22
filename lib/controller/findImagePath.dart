import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;
import 'package:absent_project/controller/Models/imagePathModels.dart' as imagesModels;



class findImageController {

  String? emailAddress,otpCodes;
  var dataUsers;

  Future findImages() async{

    String IdInputs = IdMemberControllers.text;

    try{

      var findAPI = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findImagePath.php");
      var resp = await http.post(
          findAPI,
          body: {
            'user_id' : '12'
          }
      );

      dataUsers = jsonDecode(resp.body);
      imagesModels.impagesPath = dataUsers[0]['image_path'];
      print(IdInputs);


    } catch(exception) {
      return "Can not find otp code";
    }
  }
}