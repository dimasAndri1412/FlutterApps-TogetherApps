import 'dart:convert';

import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;

class insertClockInControllers {
  String? fullNames,UserNames,ProjectNames,LocationClockIns,shiftClcokIn,NotesClockIn;
  var clockINUsers;

  Future insertClockInValues() async {

    String fullNamesInput = fullNamesLocationController.text;
    String userNamesInput = userNameLocationFieldController.text;
    String projectInputs = projectLocationFieldController.text;
    String locationInputs = locationFieldController.text;
    String shiftInputs = shiftLOcationFieldController.text;
    String noteClockInInputs = notesClockInController.text;

    try{

      var clockINUrl = Uri.parse("http://192.168.2.159:8080/FlutterAPI/insertClockInAbsent.php");
      var resp = await http.post(
          clockINUrl,
          body: {
            'full_names' : fullNamesInput,
            'user_name' : userNamesInput,
            'project_name' : projectInputs,
            'location_clockin' : locationInputs,
            'shift' : shiftInputs,
            'notes' : noteClockInInputs
          }
      );

      clockINUsers = jsonDecode(resp.body);

    }catch(errs) {
      return "can not insert clockin";
    }

  }
}