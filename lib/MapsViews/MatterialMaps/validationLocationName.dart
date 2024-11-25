import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;

class validatioLocationName {

  String? locatioNames;
  var validationLocationValues;

  Future verfiyLocationName() async {

    String? locationNameInput = SearchLocationController.text;
    
    var getLocationName = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findValidationLocationName.php");
    var respGetLocationName = await http.post(
      getLocationName,
      body: {
        'location_name' : locationNameInput
      }
    );
    validationLocationValues = jsonDecode(respGetLocationName.body);
  }
}
