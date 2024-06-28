import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../approvalls/lembur/pengajuan_lembur.dart';
import '../../../approvalls/lembur/pengajuan_lembur_shifting.dart';
import '../../Keys.dart';
import 'MemberRequestOvertimeGetListModel.dart';
import 'MemberRequestOvertimeModel.dart';

class MemberRequestOvertimeController {

  final MemberRequestOvertimeModel getData = MemberRequestOvertimeModel();

   Future getInfo() async {
    var data = await http.post(
        Uri.parse(
            "http://10.233.77.55/FlutterAPI/approvals/member/overtime/getFullName.php"),
        body: {
          "username": emailController.text,
        });
    var jsonData = json.decode(data.body);
    getData.full_name = jsonData[0]['full_name'];
    getData.project = jsonData[0]['grup'];
    getData.shiftingStatus = jsonData[0]['shiftingStatus'];

    nameOTController.text = getData.full_name;
    projectOTController.text = getData.project;

    if (getData.shiftingStatus == "yes") {
      Get.off(() => const PengajuanLemburShifting());
    } else {
      Get.off(() => const PengajuanLembur());
    }
  }

  save() async {
    final response = await http.post(
      Uri.parse(
          "http://10.233.77.55/FlutterAPI/approvals/member/overtime/saveMemberRequestOT.php"),
      body: {
        "fullname": nameOTController.text,
        "position": positionOTController.text,
        "project": projectOTController.text,
        "department": departmentOTController.text,
        "shift": shiftOTController.text,
        "start_date": dateOTController.text,
        "start_time": timeStartOTController.text,
        "end_time": timeEndOTController.text,
        "activity": activityOTController.text,
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  clearInfo(){
    nameOTController.clear();
    positionOTController.clear();
    projectOTController.clear();
    departmentOTController.clear();
    shiftOTController.clear();
    dateOTController.clear();
    timeStartOTController.clear();
    timeEndOTController.clear();
    activityOTController.clear();
  }

  Future<List<MemberRequestOvertimeGetListModel>?> getList() async {
    var getFullName = await http.post(
        Uri.parse("http://10.233.77.55/FlutterAPI/approvals/member/overtime/getFullName.php"),
        body: {"username": emailController.text}
    );
    var jsonGetFullName = json.decode(getFullName.body);
    nameOTController.text = jsonGetFullName[0]['full_name'];
    //
    var data = await http.post(
        Uri.parse("http://10.233.77.55/FlutterAPI/approvals/member/overtime/getListUser.php"),
        body: {
          "name": nameOTController.text,
        });
    var jsonData = json.decode(data.body);
    activityOTController.text = jsonData[0]['activity'];
    dateOTController.text = jsonData[0]['start_date'];
    nameOTController.text = jsonData[0]['full_name'];
    statusOTController.text = jsonData[0]['status'];



    List<MemberRequestOvertimeGetListModel> users = [];

    for (var u in jsonData) {
      MemberRequestOvertimeGetListModel user = MemberRequestOvertimeGetListModel.fromJson(u);
      users.add(user);
      /*MemberRequestOvertimeGetListModel user = MemberRequestOvertimeGetListModel(
          activity: u["activity"],
          start_date: u["start_date"],
          full_name: u["full_name"],
          status: u["status"]);
      users.add(user);*/
    }
    return users;
  }

}