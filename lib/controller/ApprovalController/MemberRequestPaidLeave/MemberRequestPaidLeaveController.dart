import 'dart:convert';

import 'package:absent_project/approvalls/cuti/pengajuan_cuti_development.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../approvalls/cuti/list_pengajuan_cuti.dart';
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

  clearInfo(){
    namePaidLeave.clear();
    positionPaidLeave.clear();
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
        Uri.parse("http://192.168.2.159/FlutterAPI/approvals/member/paid_leave/getFullName.php"),
        body: {
    "username": emailController.text,
    });
    var jsonData = json.decode(data.body);
    memberInfo.full_name = jsonData[0]['full_name'];
    memberInfo.project = jsonData[0]['grup'];

    namePaidLeave.text = memberInfo.full_name;

    if(memberInfo.project == "Development Project"){
      Get.to(() => const PengajuanCuti_Development());
    }else{
      Get.to(() => const PengajuanCuti());
    }

  }

  Future<List<MemberListPaidLeave>?> getList() async {
    var getFullName = await http.post(
      Uri.parse("http://192.168.2.159/FlutterAPI/approvals/member/paid_leave/getFullName.php"),
      body: {"username": emailController.text}
    );
    var jsonGetFullName = json.decode(getFullName.body);
    namePaidLeave.text = jsonGetFullName[0]['full_name'];
    //
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
