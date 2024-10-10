import 'dart:convert';

import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;

class insertClockOutControllers {
  String? fullNames,UserNames,ProjectNames,LocationClockIns,shiftClcokIn,NotesClockIn;
  var clockINUsers;

  Future insertClockOutValues() async {
    String fullNamesInput = fullNamesLocationController.text;
    String userNamesInput = userNameLocationFieldController.text;
    String projectInputs = projectLocationFieldController.text;
    String locationInputs = locationFieldController.text;
    String shiftInputs = shiftClockOutController.text;
    String clocInInputs = clockInController.text;
    String elapsedInputs = elapsedTimesController.value.text;
    String noteClockInInputs = notesClcokOutController.text;

    try{

      var clockINUrl = Uri.parse("http://192.168.2.159:8080/FlutterAPI/insertClockOutAbsent.php");
      var resp = await http.post(
          clockINUrl,
          body: {
            'full_names' : fullNamesInput,
            'user_name' : userNamesInput,
            'project_name' : projectInputs,
            'location_clockout' : locationInputs,
            'shift' : shiftInputs,
            'clock_in' : clocInInputs,
            'elapsed_time' : elapsedInputs,
            'notes' : noteClockInInputs
          }
      );

      clockINUsers = jsonDecode(resp.body);

    }catch(errs) {
      return "can not insert clockin";
    }

  }
}