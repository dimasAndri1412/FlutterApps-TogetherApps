import 'dart:convert';

import 'package:absent_project/controller/Keys.dart';

import 'AdminApprovalOvertimeModel.dart';
import 'package:http/http.dart' as http;

class AdminApprovalOvertimaController{
  Future<List<AdminApprovalOvertimeModel>?> getList() async {
    var data = await http.post(
        Uri.parse("http://10.233.77.55/FlutterAPI/approvals/admin/overtime/getListUser.php"),);
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
      Uri.parse("http://10.233.77.55/FlutterAPI/approvals/admin/overtime/update_rejected.php"),
      body: {
        "reason_rejected": reason_rejectedController.text,
        "full_name": nameOTController.text,
      },
    );
    if (response.statusCode == 200){
      return true;
    }
    return false;
  }
}