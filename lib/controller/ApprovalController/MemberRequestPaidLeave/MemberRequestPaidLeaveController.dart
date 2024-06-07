import 'dart:convert';

import 'package:absent_project/approvalls/cuti/pengajuan_cuti_development_project.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../approvalls/cuti/pengajuan_cuti.dart';
import '../../Keys.dart';
import 'MemberListPaidLeave.dart';
import 'MemberRequestPaidLeave.dart';

class MemberRequestPaidLeaveController {
  final MemberRequestPaidLeave memberInfo = MemberRequestPaidLeave();
  //fungsi untuk melakukan penyimpanan data//
  save() async {
    final response = await http.post(
      Uri.parse(
          "http://192.168.2.159/FlutterAPI/approvals/member/paid_leave/setUserApproval.php"),
      body: {
        "name": namePaidLeave.text,
        "position": positionPaidLeave.text,
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

  Future getInfo() async {
    var data = await http.post(
        Uri.parse("http://192.168.2.159/FlutterAPI/approvals/member/paid_leave/getFullName.php"),
        body: {
    "username": emailController.text,
    });
    var jsonData = json.decode(data.body);
    memberInfo.full_name = jsonData[0]['full_name'];
    memberInfo.project = jsonData[0]['grup'];

    namePaidLeave.text = memberInfo.full_name;

    if(memberInfo.project == "MSDO Project"){
      Get.to(() => const PengajuanCuti());
    }else{
      Get.to(() => const PengajuanCuti_Development());
    }
  }

  Future<List<MemberListPaidLeave>?> getList() async {
    var data = await http.post(
        Uri.parse("http://192.168.2.159/FlutterAPI/approvals/member/paid_leave/getListUser.php"),
        body: {
          "name": namePaidLeave.text,
        });
    var jsonData = json.decode(data.body);

    List<MemberListPaidLeave> users = [];

    for (var u in jsonData) {
      MemberListPaidLeave user = MemberListPaidLeave(u["name"], u["date_start_leave"], u["status"],
          u["reason_leave"]);
      users.add(user);
    }
    return users;
  }
}
