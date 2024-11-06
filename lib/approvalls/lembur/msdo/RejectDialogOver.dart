import 'package:absent_project/approvalls/lembur/msdo/ListUserLembur.dart';
import 'package:absent_project/controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertimeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Rejectdialogover extends StatefulWidget {
  AdminApprovalOvertimeModel gettingData;
  Rejectdialogover({super.key, required this.gettingData});

  @override
  State<Rejectdialogover> createState() => _RejectdialogoverState();
}

class _RejectdialogoverState extends State<Rejectdialogover> {
  updateOverRejected() async {
    final response = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/admin/overtime/update_rejected.php"),
        body: {
          "reason_rejected": reason_OTrejectedController.text,
          "reqNo": widget.gettingData.reqNo,
        });
    if (response.statusCode == 200) {
      return true;
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
              height: 120,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Icon(
                    Icons.question_mark_rounded,
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
              'Why you reject this request?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 14.0),
            Column(
              children: [
                Container(
                  height: 100,
                  width: 270,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 8),
                    child: TextField(
                      controller: reason_rejectedController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter the reason here',
                      ),
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
                      updateOverRejected();
                      reason_OTrejectedController.text = '';
                      // const ListUserCuti();
                      Get.offAll(const ListUserLembur());
                    },
                    child: Text(
                      "Reject",
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
