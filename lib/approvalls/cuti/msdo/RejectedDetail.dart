import 'package:absent_project/approvalls/cuti/msdo/RejectedReasonDialog.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/approvalls/cuti/GeneratePDF_MSDO.dart';
import 'package:absent_project/approvalls/cuti/msdo/ConfirmationDialog.dart';
import 'package:absent_project/approvalls/cuti/msdo/RejectDialog.dart';
import 'package:flutter/material.dart';
// import 'package:absent_project/approvalls/cuti/GeneratePDF_Development.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'package:printing/printing.dart';

import '../../../controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeaveModel.dart';

class RejectedDetail extends StatefulWidget {
  final AdminApprovalPaidLeaveModel getUserDetail;
  const RejectedDetail({super.key, required this.getUserDetail});

  @override
  _RejectedDetailState createState() => _RejectedDetailState();
}

class _RejectedDetailState extends State<RejectedDetail> {
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDialog();
    });
  }

  void _showDialog() {
    if (!_isDialogShown) {
      _isDialogShown = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return RejectedReasonDialog(getData: widget.getUserDetail);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Detail Approval",
            style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 147, 195, 234),
                Color.fromARGB(255, 98, 171, 232),
                Color.fromARGB(255, 123, 185, 235),
              ]
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(10),
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.cancel, color: Colors.red),
                    SizedBox(width: 5),
                    Text(
                      "Status : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.getUserDetail.status,
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 10),
              height: 70,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 152, 188, 210).withOpacity(0.2),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.document_scanner_sharp,
                    color: Colors.white,
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      "No Request : ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      widget.getUserDetail.reqNo,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text(
                      "Submitted Date ",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      widget.getUserDetail.submittedDate,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 10, right: 10),
              width: 350,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
                border: Border.all(width: 0.5, color: Colors.grey),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request Detail",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      indent: 2,
                      endIndent: 2,
                    ),
                    SizedBox(height: 10),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Submitted by",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget.getUserDetail.username,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget.getUserDetail.phoneNumber,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      indent: 2,
                      endIndent: 2,
                    ),
                    SizedBox(height: 5),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Position",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget.getUserDetail.position,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Department",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget.getUserDetail.departement,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      indent: 2,
                      endIndent: 2,
                    ),
                    SizedBox(height: 5),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Leave Type",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget.getUserDetail.types_leave,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Shift",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget.getUserDetail.shift,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      indent: 2,
                      endIndent: 2,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Reason of Leave : ",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Expanded(
                          child: Text(
                            widget.getUserDetail.reason_leave,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Leave Date ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 140,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              widget.getUserDetail.date_start_leave,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(" - "),
                        Spacer(),
                        Container(
                          width: 140,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              widget.getUserDetail.date_end_leave,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Name Of PIC : ",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          widget.getUserDetail.name_of_pic,
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Will return to work on : ",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          widget.getUserDetail.date_back_to_work,
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return RejectedReasonDialog(getData: widget.getUserDetail);
                  },
                );
              },
              child: Text(
                'Your request has been Rejected',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
