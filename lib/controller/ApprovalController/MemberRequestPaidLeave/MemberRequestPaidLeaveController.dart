import 'dart:convert';

import 'package:absent_project/approvalls/cuti/user/pengajuan_cuti_development.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberStatusPaidLeave.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../approvalls/cuti/user/pengajuan_cuti.dart';
import '../../Keys.dart';
import 'MemberListPaidLeave.dart';
import 'MemberRequestPaidLeave.dart';
import 'UserListPaidLeave.dart';

class MemberRequestPaidLeaveController {
  final MemberRequestPaidLeave memberInfo = MemberRequestPaidLeave();

  int remainingLeave = 0;
  int leaveUsed = 0;
  int initial = 0;

  int countStatus = 0;
  int leaveCount = 0;
  String name = "";
  String leave_remains_string = "";
  String leave_used_string = "";
  //fungsi untuk melakukan penyimpanan data//
  save() async {
    final response = await http.post(
      Uri.parse(
          "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/setUserApproval.php"),
      body: {
        "name": namePaidLeave.text,
        "position": positionPaidLeave.text,
        "project": projectPaidLeave.text,
        "department": departmentPaidLeave.text,
        "types_leave": typePaidLeave.text,
        "reason_leave": reasonPaidLeave.text,
        "name_of_pic": picPaidLeave.text,
        "phone_number": phonePaidLeave.text,
        "shift": shiftPaidLeave.text,
        "date_start_leave": startDatePaidLeave.text,
        "date_end_leave": endDatePaidLeave.text,
        "date_back_to_work": onDutyPaidLeave.text,
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  clearInfo() {
    namePaidLeave.clear();
    positionPaidLeave.clear();
    projectPaidLeave.clear();
    departmentPaidLeave.clear();
    typePaidLeave.clear();
    reasonPaidLeave.clear();
    picPaidLeave.clear();
    phonePaidLeave.clear();
    shiftPaidLeave.clear();
    startDatePaidLeave.clear();
    endDatePaidLeave.clear();
    onDutyPaidLeave.clear();
    statusPaidLeave.clear();
  }

  Future getInfo() async {
    var data = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getFullName.php"),
        body: {
          "username": emailController.text,
        });
    var jsonData = json.decode(data.body);
    memberInfo.full_name = jsonData[0]['full_name'];
    memberInfo.project = jsonData[0]['project_name'];
    memberInfo.position = jsonData[0]['position_name'];
    memberInfo.department = jsonData[0]['division_name'];
    // memberInfo.shiftingStatus = jsonData[0]['shiftingStatus'];

    namePaidLeave.text = memberInfo.full_name;
    projectPaidLeave.text = memberInfo.project;
    positionPaidLeave.text = memberInfo.position;
    departmentPaidLeave.text = memberInfo.department;

    // if (memberInfo.shiftingStatus == "no") {
    //   Get.to(() => const PengajuanCuti_Development());
    // } else {
    //   Get.to(() => const PengajuanCuti());
    // }
  }

  Future<List<MemberListPaidLeave>?> getList() async {
    var getFullName = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getFullName.php"),
        body: {"username": emailController.text});
    var jsonGetFullName = json.decode(getFullName.body);
    namePaidLeave.text = jsonGetFullName[0]['full_name'];
    //
    var data = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getListUser.php"),
        body: {
          "name": namePaidLeave.text,
        });
    var jsonData = json.decode(data.body);
    reasonPaidLeave.text = jsonData[0]['reason_leave'];
    startDatePaidLeave.text = jsonData[0]['date_start_leave'];
    namePaidLeave.text = jsonData[0]['name'];
    statusPaidLeave.text = jsonData[0]['status'];

    List<MemberListPaidLeave> users = [];

    for (var u in jsonData) {
      MemberListPaidLeave user = MemberListPaidLeave.fromJson(u);
      users.add(user);
      // MemberListPaidLeave user = MemberListPaidLeave(
      //     u["name"], u["date_start_leave"], u["status"], u["reason_leave"]);
      // users.add(user);
    }
    return users;
  }

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 3));
    // await getLeave();
  }

  Future/*<List<UserListPaidleave>?>*/ getLeaveNew() async {
    var getName = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getLeaveNew.php"),
        body: {"username": emailController.text});
    var jsonGetName = json.decode(getName.body);

    leaveUsed = int.parse(jsonGetName[0]['leave_used']);
    remainingLeave = int.parse(jsonGetName[0]['remaining_leave']);
  }

  Future getCountandLeave() async {
    var getCount = await http.post(
        Uri.parse(
          "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getCountLeave.php",
        ),
        body: {"name": emailController.text});
    var jsonGetCount = json.decode(getCount.body);
    countStatus = int.parse(jsonGetCount[0]['countStatus']);

    var getName = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getLeaveNew.php"),
        body: {"username": emailController.text});
    var jsonGetName = json.decode(getName.body);

    leaveUsed = int.parse(jsonGetName[0]['leave_used']);
    remainingLeave = int.parse(jsonGetName[0]['remaining_leave']);
  }

  Future<List<MemberStatuspaidleave>?> getStatus() async {
    var data = await http.post(Uri.parse(
        "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getStatus.php"));
    List<dynamic> jsonData = json.decode(data.body);
    List<MemberStatuspaidleave> users = [];

    for (var u in jsonData) {
      MemberStatuspaidleave user = MemberStatuspaidleave.fromJson(u);
      users.add(user);
    }
    return users;
  }
}
