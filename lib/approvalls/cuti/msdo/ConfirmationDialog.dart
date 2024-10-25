import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
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

  int leaveUsed = 0;
  int remainingLeave = 0;
  int countStatus = 0;
  int initial = 0;
  int totalLeave = 12;

  //update approval
  updateApproved() async {
    final response = await http.post(
      Uri.parse(
          "http://192.168.2.159:8080/FlutterAPI/approvals/admin/paid_leave/update_approved.php"),
      body: {"reqNo": widget.getUserDetail.reqNo},
    );
    if (response.statusCode == 200) {
      // return true;
      await updateLeave();
      // await getLeaveUpdate.getLeave();
    }
    return false;
  }

  updateLeave() async {
    var data = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getFullNameOther.php"),
        body: {
          // "username": emailController.text,
          "full_name": namePaidLeave.text
        });
    var jsonData = json.decode(data.body);
    // namePaidLeave.text = jsonData[0]['full_name'];
    // print("Data.body: ${data.body}");

    leaveUsed = int.parse(jsonData[0]['leave_used']);
    remainingLeave = int.parse(jsonData[0]['remaining_leave']);

    leave_used.text = leaveUsed.toString();
    remaining_leave.text = remainingLeave.toString();

    print("Leave Used dari API: $leaveUsed");
    print("Remaining Leave dari API: $remainingLeave");

    var getData = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getCountLeave.php"),
        body: {
          "name": namePaidLeave.text,
        });
    var getJsondata = json.decode(getData.body);
    print("getData.body: ${getData.body}");

    countStatus = int.parse(getJsondata[0]['countStatus']);
    initial = remainingLeave;

    if (countStatus > 0) {
      leaveUsed = (countStatus);
      // initial -= leaveUsed;
      initial = totalLeave - leaveUsed;
    } else {
      // leaveUsed = 0;
      print("NO DATA COUNT");
    }

    print("countStatus getting : $countStatus");
    print("Leave used getting: $leaveUsed");
    print("initial getting: $initial");
    print("Remaining Leave getting: $remainingLeave");

    // await updatePaidLeave();
    // await updatePaidLeave(widget.getUserDetail.username, leaveUsed, initial);
    await refresh();
  }

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 3));
    // await updatePaidLeave(widget.getUserDetail.username, leaveUsed, initial);
    await updatePaidLeave(namePaidLeave.text, leaveUsed, initial);
  }

  updatePaidLeave(String username, int leaveUsed, int initial) async {
    final response = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/admin/paid_leave/update_leave.php"),
        body: {
          // 'username': username,
          'full_name': namePaidLeave.text,
          'leave_used': leaveUsed.toString(),
          'remaining_leave': initial.toString()
        });

    if (response.statusCode == 200) {
      // return true;
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
                ElevatedButton(
                  onPressed: () async {
                    final pdf = await PDFGenerator_MSDO(
                      getUserDetail: widget.getUserDetail,
                    ).GeneratePDF();
                    await Printing.layoutPdf(onLayout: (format) => pdf);
                    setState(() {
                      updateApproved();

                      // await updateLeave();
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.print,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Approve & Print Document',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
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
