import 'dart:convert';

import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeGetStatusModel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../approvalls/lembur/msdo/pengajuan_lembur.dart';
import '../../../approvalls/lembur/user/pengajuan_lembur_shifting.dart';
import '../../Keys.dart';
import 'MemberRequestOvertimeGetListModel.dart';
import 'MemberRequestOvertimeModel.dart';

class MemberRequestOvertimeController {
  final MemberRequestOvertimeModel getData = MemberRequestOvertimeModel();

  Future getInfo() async {
    var data = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/overtime/getFullName.php"),
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
          "http://192.168.2.159:8080/FlutterAPI/approvals/member/overtime/saveMemberRequestOT.php"),
      body: {
        "fullname": nameOTController.text,
        "location": locationOTController.text,
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

  clearInfo() {
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
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/overtime/getFullName.php"),
        body: {"username": emailController.text});
    var jsonGetFullName = json.decode(getFullName.body);
    nameOTController.text = jsonGetFullName[0]['full_name'];
    //
    var data = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/overtime/getListUser.php"),
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
      MemberRequestOvertimeGetListModel user =
          MemberRequestOvertimeGetListModel.fromJson(u);
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

  Future<List<MemberRequestOvertimeGetStatusModel>?> getStatus() async {
    var data = await http.post(Uri.parse(
        "http://192.168.2.159:8080/FlutterAPI/approvals/member/overtime/getStatus.php"));
    List<dynamic> jsonData = json.decode(data.body);
    List<MemberRequestOvertimeGetStatusModel> users = [];

    for (var u in jsonData) {
      MemberRequestOvertimeGetStatusModel user =
          MemberRequestOvertimeGetStatusModel.fromJson(u);
      users.add(user);
    }
    return users;
  }

  Future<List<MemberRequestOvertimeGetListModel>?> getAllName() async {
    try {
      var response = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/admin/overtime/getAllName.php"),
      );

      // Cek status HTTP
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        // getData.project = jsonData[0]['project_name'];
        print(
            'Raw JSON response: $jsonData'); // Log untuk memeriksa respons API

        // Pastikan jsonData adalah List
        if (jsonData is List) {
          List<MemberRequestOvertimeGetListModel> users = jsonData.map((u) {
            return MemberRequestOvertimeGetListModel.fromJson(u);
          }).toList();

          print('Parsed user list: $users');
          return users;
        } else {
          print('Unexpected JSON format');
          return null;
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
}
