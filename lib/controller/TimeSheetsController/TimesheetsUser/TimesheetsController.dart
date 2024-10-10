import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetsUser/MonthlyTimesheetModel.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetsUser/TimesheetsModel.dart';
import 'package:absent_project/timesheets/timesheetsUser/monthlyTimesheets.dart';
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
        Uri.parse("http://192.168.100.84/FlutterAPI/timesheet/user/get_tracked_time_byDate.php"),
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

  getAnswers(DateTime selectedDay) async {
    String? userId = await _loginController.getUserId();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
    try {
      final response = await http.post(
        Uri.parse("http://192.168.100.84/FlutterAPI/timesheet/user/get_answers.php"),
        body: {
          'user_id': userId,
          'date': formattedDate
        },
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}"); 

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body); // Decode JSON response
        return data;
      }  else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<MonthlyTimesheetModel>> getMonthly (int selectedMonth, int selectedYear) async {
    String? userId = await _loginController.getUserId();
    try {
      final response = await http.post(
        Uri.parse("http://192.168.100.84/FlutterAPI/timesheet/user/monthly_timesheets.php"),
        body: {
          'user_id': userId,
          'month': selectedMonth.toString(),
          'year':  selectedYear.toString()
        },
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}"); 

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<MonthlyTimesheetModel> monthlyTimesheetModel= jsonData.map((item) => MonthlyTimesheetModel.fromJson(item)).toList();
        return monthlyTimesheetModel  ;
      }  else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<MonthlyTimesheetModel> detailMonthly (int selectedMonth, int selectedYear, String? clockOutId) async {
    String? userId = await _loginController.getUserId();
    try {
      final response = await http.post(
        Uri.parse("http://192.168.100.84/FlutterAPI/timesheet/user/detail_monthly_timesheets.php"),
        body: {
          'user_id': userId,
          'month': selectedMonth.toString(),
          'year':  selectedYear.toString(),
          'clock_out_id':  clockOutId
        },
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}"); 

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final MonthlyTimesheetModel timesheetsModel= MonthlyTimesheetModel.fromJson(jsonData[0]);
        return timesheetsModel;
      }  else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
  
}