import 'package:absent_project/approvalls/sakit/admin/ListUserSakit.dart';
import 'package:absent_project/approvalls/sakit/admin/RejectedDetail.dart';
import 'package:absent_project/controller/ApprovalController/SickLeaveController/Admin/AdminSickLeaveController.dart';
import 'package:absent_project/controller/ApprovalController/SickLeaveController/Admin/ListSickLeaveModel.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeaveModel.dart';
import 'package:http/http.dart' as http;


class RejectDialog extends StatefulWidget {
  ListSickLeaveModel getData;
  RejectDialog({super.key, required this.getData});

  @override
  State<RejectDialog> createState() => _RejectDialogState();
}

class _RejectDialogState extends State<RejectDialog> {

  @override
  void dispose() {
    // TODO: implement dispose
    rejectedReasonSickLeave.clear();
    super.dispose();
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
                      controller: rejectedReasonSickLeave,
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
                      AdminSickLeaveController adminSickLeaveController = AdminSickLeaveController();
                      Navigator.pop(context);
                      adminSickLeaveController.updateRejected(widget.getData.reqId);
                      // rejectedReasonSickLeave.clear();
                      // reason_rejectedController.text = '';
                      // const ListUserCuti();
                      Get.offAll(ListUserSakit());
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
