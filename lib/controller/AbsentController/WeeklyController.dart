import 'dart:convert';

import 'package:absent_project/controller/AbsentController/WeeklyModel.dart';
import 'package:absent_project/controller/LoginController.dart';
import 'package:http/http.dart' as http;

class WeeklyController {
   LoginController _loginController = LoginController();

   Future<List<WeeklyModel>> fetchWeeklyData() async {
    try {
      String? userId = await _loginController.getUserId();
      if (userId == null) {
        print('User ID tidak ditemukan');
        // return false;
      }

      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/home/getWeekData.php"),
        body: {
          'user_id' : userId
        }
      );
      print('response weekly: ${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        List<WeeklyModel> daysData = data.map((json) => WeeklyModel.fromJson(json)).toList();

        List<String> daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
        List<WeeklyModel> fullWeekData = daysOfWeek.map((day) {
          var weeklyModel = daysData.firstWhere(
            (item) => item.day == day,
            orElse: () => WeeklyModel(day: day, totalHours: "00:00:00")
          );
          return weeklyModel;
        }).toList();
        return fullWeekData;
        } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print('Error : $e');
      return[];
    }
  }
}
