import 'package:absent_project/controller/ApprovalController/SickLeaveController/Admin/ListSickLeaveModel.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/LoginController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminSickLeaveController {
  LoginController _loginController = LoginController();
  Future<List<ListSickLeaveModel>?> getUsers() async {
    try {
      var url = Uri.parse(
          "http://192.168.2.159:8080/FlutterAPI/approvals/admin/sick_leave/getUser_sickLeave.php");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData is List) {
          List<ListSickLeaveModel> users = jsonData
              .map((user) => ListSickLeaveModel.fromJson(user))
              .toList();
          return users;
        } else {
          print("Unexpected JSON format");
          return null;
        }
      } else {
        print("Failed to fetch : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  updateApproved(String reqId) async {
     String? userId = await _loginController.getUserId();
    final response = await http.post(
      Uri.parse(
          "http://192.168.2.159:8080/FlutterAPI/approvals/admin/sick_leave/update_approved.php"),
      body: {
        "reqId":  reqId,
        "adminId" : userId
      },
    );
    if (response.statusCode == 200) {
      print("response: ${response.body}");
      return true;
    }else {
      print("Error: ${response.statusCode} - ${response.body}");
      return false; 
    }
  }

  updateRejected(String reqId) async {
     String? userId = await _loginController.getUserId();
    final response = await http.post(
      Uri.parse(
          "http://192.168.2.159:8080/FlutterAPI/approvals/admin/sick_leave/update_rejected.php"),
      body: {
        "reqId":  reqId,
        "adminId" : userId,
        "rejectedReason" : rejectedReasonSickLeave.text
      },
    );
    if (response.statusCode == 200) {
      print("response: ${response.body}");
      return true;
    }else {
      print("Error: ${response.statusCode} - ${response.body}");
      return false; 
    }
  }
}