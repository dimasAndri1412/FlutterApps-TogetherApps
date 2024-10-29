import 'dart:convert';
import 'package:absent_project/controller/LoginController.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/ListTimesheetsModel.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/MonthlyReportModel.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:absent_project/controller/TimeSheetsController/TimesheetsUser/MonthlyTimesheetModel.dart';

class ListTimesheetsController {
  LoginController _loginController = LoginController();

  Future<List<ListTimesheetsModel>> getList (DateTime selectedDate) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/timesheet/admin/timesheets.php"),
        body: {
          'date': formattedDate,
        },
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}"); 

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<ListTimesheetsModel> listTimesheetsModel= jsonData.map((item) => ListTimesheetsModel.fromJson(item)).toList();
        return listTimesheetsModel  ;
      }  else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<ListTimesheetsModel> getDaily (DateTime selectedDate, String clockInId) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/timesheet/admin/dailyTimesheets.php"),
        body: {
          'date': formattedDate,
          'clock_in_id' : clockInId
        },
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}"); 

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final ListTimesheetsModel listTimesheetsModel= ListTimesheetsModel.fromJson(jsonData[0]);
        return listTimesheetsModel;
      }  else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<MonthlyTimesheetModel>> getMonthly (String userId, int selectedMonth, int selectedYear) async {
    try {
      DateTime firstDayOfMonth = DateTime(selectedYear, selectedMonth);

      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/timesheet/user/monthly_timesheets.php"),
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
        final List<MonthlyTimesheetModel> monthlyTimesheetModel= jsonData
        .map((item) => MonthlyTimesheetModel.fromJson(item))
        .toList();
        return monthlyTimesheetModel  ;
      }  else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<String> fetchFullName(String userId) async {
    try {
      var response = await http.get(Uri.parse('http://192.168.2.159:8080/FlutterAPI/GetUserById.php/$userId'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['full_name'];
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }

  Future<String> getFullName(String userId) async {
    try {
      String fullName = await fetchFullName(userId);
      return fullName;
    } catch (e) {
      print('Error fetching full name: $e');
      return 'Unknown'; 
    }
  }

  Future<MonthlyReportModel> getMonthlyReport (String userId, int selectedMonth, int selectedYear) async {
    try {
      DateTime firstDayOfMonth = DateTime(selectedYear, selectedMonth);

      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/timesheet/admin/monthly_report.php"),
        body: {
          'user_id': userId,
          'month': selectedMonth.toString(),
          'year':  selectedYear.toString()
        },
      );

      print("API Response Status: ${response.statusCode}");
      print("Monthly report: ${response.body}"); 

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        if (jsonData.isNotEmpty && jsonData['status'] == 'success') {
          return MonthlyReportModel.fromJson(jsonData);
        } else {
          throw Exception("Failed to parse data");
        }
      }  else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}