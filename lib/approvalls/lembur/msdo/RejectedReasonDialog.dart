import 'package:flutter/material.dart';

import 'package:absent_project/controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertimeModel.dart';

class RejectedReasonDialog extends StatelessWidget {
  AdminApprovalOvertimeModel gettingData;
  RejectedReasonDialog({super.key, required this.gettingData});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        // width: 100,
        //  decoration: BoxDecoration(
        //    color: Colors.red[100],
        //    borderRadius: BorderRadius.circular(20)
        //  ),
        // height: 200,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 50,
                ),
              )),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Rejected Reason",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(child: Text(gettingData.reason_rejected))
            ],
          ),
        ),
      ),
    );
  }
}
