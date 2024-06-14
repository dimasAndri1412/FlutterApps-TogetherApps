import 'dart:convert';
import 'dart:math';
import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;
import 'AdminApprovalPaidLeave_Development.dart';
import 'AdminApprovalPaidLeave_MSDO.dart';
import 'adminGetDetail.dart';

class AdminApprovalPaidLeaveController {
  String status = "";
  String reqNo = "";
  String submittedDate = "";
  String fullName = "";
  String phoneNumber = "";
  String position = "";
  String department = "";
  String leaveType = "";
  String reasonLeave = "";
  String leaveDate = "";
  String untilDate = "";
  String pic = "";
  String backToWork = "";

  int remainingLeave = 0;
  int leaveUsed = 0;


  Future<List<AdminApprovalPaidLeave_Development>?> getUsersDevelopment() async {
      try{
        var url = Uri.parse(
            "http://192.168.2.159/FlutterAPI/approvals/admin/paid_leave/getUserDevelopment_paidLeave.php");
        var data = await http.post(url, body: {
          "name": namePaidLeave.text
        });
        if (data.statusCode == 200) {
          var jsonData = json.decode(data.body);
          List<AdminApprovalPaidLeave_Development> users = [];
          for (var u in jsonData) {
            AdminApprovalPaidLeave_Development user = AdminApprovalPaidLeave_Development(
                u["name"], u["position"], u["reqNo"], u["status"],
                u["date_start_leave"], u["phone_number"],
                u["departement"], u["types_leave"], u["reason_leave"],
                u["date_end_leave"], u["name_of_pic"], u["date_back_to_work"], u["submittedDate"],u['shift']);
            users.add(user);
          }
          return users;
        }
      }catch (Exception) {
        "Failed Request!";
      }
      return null;
    }


  Future<List<AdminApprovalPaidLeave_MSDO>?> getUsersMSDO() async {
    try{
/*
      var dataGetFullName = await http.post(
          Uri.parse(
              "http://192.168.2.159/FlutterAPI/approvals/member/paid_leave/getOnlyFullName.php"),
          body: {
            "fullname": namePaidLeave.text,
          });
      var jsonData = json.decode(dataGetFullName.body);
      leaveUsed = int.parse(jsonData[0]['leave_used']);
      remainingLeave = int.parse(jsonData[0]['remaining_leave']);
*/


      var url = Uri.parse(
          "http://192.168.2.159/FlutterAPI/approvals/admin/paid_leave/getUserMSDO_paidLeave.php");
      var data = await http.post(url, body: {
        "name": namePaidLeave.text
      });
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        List<AdminApprovalPaidLeave_MSDO> users = [];
        for (var u in jsonData) {
          AdminApprovalPaidLeave_MSDO user = AdminApprovalPaidLeave_MSDO(
              u["name"], u["position"], u["reqNo"], u["status"],
              u["date_start_leave"], u["phone_number"],
              u["departement"], u["types_leave"], u["reason_leave"],
              u["date_end_leave"], u["name_of_pic"], u["date_back_to_work"], u["submittedDate"],u["shift"],
          u['leave_used'], u['remaining_leave']);
          users.add(user);
        }
        return users;
      }
    }catch (Exception) {
      "Failed Request!";
    }
    return null;
  }


  Future getDetail() async{
      var data = await http.post(
          Uri.parse("http://192.168.2.159/FlutterAPI/approvals/admin/paid_leave/getUserDevelopment_paidLeave.php"),
          body: {
            "name": namePaidLeave.text
          });
      var jsonData = json.decode(data.body);
      status = jsonData[0]['status'];
      reqNo = jsonData[0]['reqNo'];
      submittedDate = jsonData[0]['date_start_leave'];
      fullName = jsonData[0]['name'];
      phoneNumber = jsonData[0]['phone_number'];
      position = jsonData[0]['position'];
      department = jsonData[0]['departement'];
      leaveType = jsonData[0]['types_leave'];
      reasonLeave = jsonData[0]['reason_leave'];
      leaveDate = jsonData[0]['date_start_leave'];
      untilDate = jsonData[0]['date_end_leave'];
      pic = jsonData[0]['name_of_pic'];
      backToWork = jsonData[0]['date_back_to_work'];
    }
}
