import 'package:absent_project/approvalls/cuti/msdo/ListUserCuti.dart';
import 'package:absent_project/controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeaveController.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:absent_project/approvalls/cuti/GeneratePDF_MSDO.dart';
import 'package:http/http.dart' as http;
import '../../../controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeaveModel.dart';
import 'dart:convert';

class ConfirmationDialog extends StatefulWidget {
  final AdminApprovalPaidLeaveModel getUserDetail;
  const ConfirmationDialog({super.key, required this.getUserDetail});

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  final MemberRequestPaidLeaveController getLeaveUpdate =
      MemberRequestPaidLeaveController();

  String getUserAdmin = "";
  int leaveUsed = 0;
  int remainingLeave = 0;
  int countStatus = 0;
  int initial = 0;
  int totalLeave = 12;

  //update approval
  updateApproved() async {
    try {
      var data = await http.post(
          Uri.parse(
              "http://192.168.2.159:8080/FlutterAPI/approvals/admin/paid_leave/getAdmin.php"),
          body: {'username': emailController.text});

      var jsonData = json.decode(data.body);
      getUserAdmin = jsonData[0]['get_admin'];
      print('username GET: $getUserAdmin');

      var response = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/admin/paid_leave/update_approved.php"),
        body: {
          "reqNo": widget.getUserDetail.reqNo,
          "approved_by": getUserAdmin
        },
      );

      if (response.statusCode == 200) {
        await updateLeave();
      }
    } catch (e) {
      print("Error parsing JSON data: $e");
    }
  }

  updateLeave() async {
    try {
      var data = await http.post(
        Uri.parse(
          "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getFullNameOther.php",
        ),
        body: {
          "full_name": widget.getUserDetail.username,
        },
      );

      print("Data.body: ${data.body}");
      var jsonData = json.decode(data.body);

      if (jsonData is List && jsonData.isNotEmpty) {
        leaveUsed = int.parse(jsonData[0]['leave_used']);
        remainingLeave = int.parse(jsonData[0]['remaining_leave']);

        leave_used.text = leaveUsed.toString();
        remaining_leave.text = remainingLeave.toString();

        print("Leave Used dari API: $leaveUsed");
        print("Remaining Leave dari API: $remainingLeave");
      } else {
        print("No data or empty array returned from getFullNameOther.php.");
        return;
      }

      var getData = await http.post(
        Uri.parse(
          "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getCountLeave.php",
        ),
        body: {
          "name": widget.getUserDetail.username,
        },
      );

      print("getData.body: ${getData.body}");
      var getJsondata = json.decode(getData.body);

      if (getJsondata is List && getJsondata.isNotEmpty) {
        countStatus = int.parse(getJsondata[0]['countStatus']);
        initial = remainingLeave;

        if (countStatus > 0) {
          leaveUsed = countStatus;
          initial = totalLeave - leaveUsed;
        } else {
          print("NO DATA COUNT");
        }

        print("countStatus getting: $countStatus");
        print("Leave used getting: $leaveUsed");
        print("initial getting: $initial");
        print("Remaining Leave getting: $remainingLeave");
      } else {
        print("No data found in getCountLeave.php.");
      }

      await refresh();
    } catch (e) {
      print("Error parsing JSON data: $e");
    }
  }

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 3));
    await updatePaidLeave(leaveUsed, initial);
    await Future.delayed(const Duration(milliseconds: 100));
    Get.offAll(const ListUserCuti());
  }

  updatePaidLeave(int leaveUsed, int initial) async {
    final response = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/admin/paid_leave/update_leave.php"),
        body: {
          'full_name': widget.getUserDetail.username,
          'leave_used': leaveUsed.toString(),
          'remaining_leave': initial.toString()
        });

    if (response.statusCode == 200) {
      print("leave used TOTAL: $leaveUsed");
      print("remaining leave TOTAL: $initial");
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        // padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 400,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Icon(
                    Icons.warning_rounded,
                    color: Colors.white,
                    size: 80.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Are you Sure?',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Are you sure to approve this request?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 24.0),
            Column(
              children: [
                Container(
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () async {
                      // final pdf = await PDFGenerator_MSDO(
                      //   getUserDetail: widget.getUserDetail,
                      // ).GeneratePDF();
                      // await Printing.layoutPdf(onLayout: (format) => pdf);
                      setState(() {
                        updateApproved();
                        // AdminApprovalPaidLeaveController().getAdmin();
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Approve Document',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 12.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red, width: 2.0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 12.0),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
