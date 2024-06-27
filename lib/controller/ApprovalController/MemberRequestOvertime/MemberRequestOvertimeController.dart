import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../approvalls/lembur/pengajuan_lembur.dart';
import '../../../approvalls/lembur/pengajuan_lembur_shifting.dart';
import '../../Keys.dart';
import 'MemberRequestOvertimeModel.dart';

class MemberRequestOvertimeController {

  final MemberRequestOvertimeModel memberInfo = MemberRequestOvertimeModel();

   Future getInfo() async {
    var data = await http.post(
        Uri.parse(
            "http://10.233.77.55/FlutterAPI/approvals/member/overtime/getFullName.php"),
        body: {
          "username": emailController.text,
        });
    var jsonData = json.decode(data.body);
    memberInfo.full_name = jsonData[0]['full_name'];
    memberInfo.project = jsonData[0]['grup'];
    memberInfo.shiftingStatus = jsonData[0]['shiftingStatus'];

    nameOTController.text = memberInfo.full_name;
    projectOTController.text = memberInfo.project;

    if (memberInfo.shiftingStatus == "yes") {
      Get.off(() => const PengajuanLemburShifting());
    } else {
      Get.off(() => const PengajuanLembur());
    }
  }
}