import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetsUser/TimesheetsModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:absent_project/controller/LoginController.dart';
import 'package:intl/intl.dart';

class TimesheetsController{
  LoginController _loginController = LoginController();

  // clear_func(){
  //   dateController.clear();
  // }

  Future<TimesheetsModel> getLatestAttendance(DateTime selectedDay) async {
    String? userId = await _loginController.getUserId();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
    try {
      final response = await http.post(
        Uri.parse("http://10.201.50.163/FlutterAPI/timesheet/user/get_tracked_time_byDate.php"),
        body: {
          'user_id': userId,
          'date': formattedDate
        },
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}"); 

      if (response.statusCode == 200) {
        // final Map<String, dynamic> data = json.decode(response.body);
        // return data;
        final List<dynamic> jsonData = json.decode(response.body);
        final TimesheetsModel timesheetsModel= TimesheetsModel.fromJson(jsonData[0]);
        return timesheetsModel;
      }  else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
  
}