import 'dart:convert';

import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/TimeEntryModel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TimeEntryController {
  Future<TimeEntryModel> getClockIn (String clockInId) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/timesheet/admin/entry_clockIn.php"),
        body: {
          'id' : clockInId
        },
      );

      // print("API Response Status: ${response.statusCode}");
      // print("API Response Body: ${response.body}"); 

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final TimeEntryModel timeEntryClockInModel= TimeEntryModel.fromJson(jsonData[0]);
        return timeEntryClockInModel;
      }  else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<TimeEntryModel> getClockOut (String clockOutId) async {

    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/timesheet/admin/entry_clockOut.php"),
        body: {
          'id' : clockOutId
        },
      );

      // print("API Response Status: ${response.statusCode}");
      // print("API Response Body: ${response.body}"); 

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final TimeEntryModel timeEntryClockInModel= TimeEntryModel.fromJson(jsonData[0]);
        return timeEntryClockInModel;
      }  else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  editClockInTime(String clockInId, String clockIn) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/timesheet/admin/editEntryClockIn.php"),
        body: {
          'id_clock_in' : clockInId,
          'clock_in': clockIn
        }
      );
      print('response bodyL ${response.body}');
      if (response.statusCode == 200) {
        print('Position updated');
      } else {
        print('Failed brow hayo');
      }
    } catch (e) {
      print('Error : $e');
    }
  }

  editClockOutTime(String clockOutId, String clockOut) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/timesheet/admin/editEntryClockOut.php"),
        body: {
          'id_clock_out' : clockOutId,
          'clock_out': clockOut
        }
      );
      print('response bodyL ${response.body}');
      if (response.statusCode == 200) {
        print('Position updated');
      } else {
        print('Failed brow hayo');
      }
    } catch (e) {
      print('Error : $e');
    }
  }
}