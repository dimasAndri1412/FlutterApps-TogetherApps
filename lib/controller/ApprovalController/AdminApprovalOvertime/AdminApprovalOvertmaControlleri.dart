import 'dart:convert';

import 'package:absent_project/controller/Keys.dart';

import 'AdminApprovalOvertimeGetProjectModel.dart';
import 'AdminApprovalOvertimeGetStatusModel.dart';
import 'AdminApprovalOvertimeModel.dart';
import 'package:http/http.dart' as http;

class AdminApprovalOvertimaController {
  Future<List<AdminApprovalOvertimeModel>?> getList() async {
    var data = await http.post(Uri.parse(
        "http://192.168.2.159:8080/FlutterAPI/approvals/admin/overtime/getListUser.php"));
    var jsonData = json.decode(data.body);
    nameOTController.text = jsonData[0]['full_name'];

    List<AdminApprovalOvertimeModel> users = [];

    for (var u in jsonData) {
      AdminApprovalOvertimeModel user = AdminApprovalOvertimeModel.fromJson(u);
      users.add(user);
    }
    return users;
  }

  updateRejected() async {
    final response = await http.post(
      Uri.parse(
          "http://192.168.2.159:8080/FlutterAPI/approvals/admin/overtime/update_rejected.php"),
      body: {
        "reason_rejected": reason_rejectedController.text,
        "full_name": nameOTController.text,
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<AdminApprovalOvertimeGetStatusModel>?> getStatus() async {
    var data = await http.post(Uri.parse(
        "http://192.168.2.159:8080/FlutterAPI/approvals/member/overtime/getStatus.php"));
    List<dynamic> jsonData = json.decode(data.body);
    List<AdminApprovalOvertimeGetStatusModel> users = [];

    for (var u in jsonData) {
      AdminApprovalOvertimeGetStatusModel user =
          AdminApprovalOvertimeGetStatusModel.fromJson(u);
      users.add(user);
    }
    return users;
  }

  Future<List<AdminApprovalOvertimeGetProjectModel>?> getProject() async {
    var data = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/admin/overtime/getProject.php"),
        body: {
          "username": emailController.text,
        });
    List<dynamic> jsonData = json.decode(data.body);
    List<AdminApprovalOvertimeGetProjectModel> users = [];

    for (var u in jsonData) {
      AdminApprovalOvertimeGetProjectModel user =
          AdminApprovalOvertimeGetProjectModel.fromJson(u);
      users.add(user);
    }
    return users;
  }
}
