import 'package:absent_project/controller/ApprovalController/SickLeaveController/Admin/ListSickLeaveModel.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/approvalls/cuti/GeneratePDF_MSDO.dart';
import 'package:absent_project/approvalls/cuti/msdo/ConfirmationDialog.dart';
import 'package:absent_project/approvalls/cuti/msdo/RejectDialog.dart';
import 'package:flutter/material.dart';
// import 'package:absent_project/approvalls/cuti/GeneratePDF_Development.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:printing/printing.dart';

// import '../../../controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeaveModel.dart';

class RejectedDetail extends StatelessWidget {
  final ListSickLeaveModel getUserDetail;
  const RejectedDetail({super.key,
  required this.getUserDetail});


  @override
  Widget build(BuildContext context) {
   String? formattedDate = getUserDetail.submittedDate != null ? DateFormat('dd MMM yyyy HH:mm').format(getUserDetail.submittedDate!) : null;
   String? sickDate = getUserDetail.date != null ? DateFormat('dd MMM yyyy').format(getUserDetail.date!) : null;
   String? approvedDate = getUserDetail.actionDate != null ? DateFormat('dd MMM yyyy HH:mm').format(getUserDetail.actionDate!) : null;

    return Scaffold(
      appBar: AppBar(
        title:Center(
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
      body:SingleChildScrollView(
        child:  Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(10),
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.cancel, color: Colors.red,),
                    SizedBox(width: 5,),
                    Text(
                      "Status : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      getUserDetail.status,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold
                      ),
                    )
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
                title:Row(
                  children: [
                    Text(
                      "No Request : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    Text(getUserDetail.reqId,
                      style: TextStyle(
                        fontSize: 14
                      ),
                    )
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text(
                      "Submitted Date ",
                      style: TextStyle(
                      fontSize: 12),
                      ),
                    Text(formattedDate ?? '-',
                      style: TextStyle(
                        fontSize: 12
                      ),
                    )
                  ],
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 10, right: 10),
              width: 350,
              height: 460,
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
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      indent: 2,
                      endIndent: 2,
                    ),
                    SizedBox(height: 10,),
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
                                  getUserDetail.fullName,
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
                                  getUserDetail.phoneNumber,
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
                                  getUserDetail.positionName,
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
                                  "Project",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  getUserDetail.projectName,
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
                    SizedBox(height: 5,),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Division",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(getUserDetail.divisionName,
                                  style: TextStyle(
                                    fontSize: 13
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Company",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(getUserDetail.companyName,
                                  style: TextStyle(
                                    fontSize: 13
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      indent: 2,
                      endIndent: 2,
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("Sick Information : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13
                          ),
                        ),
                        Expanded(
                          child: Text(getUserDetail.note,
                            style: TextStyle(
                              fontSize: 13
                            ),
                          )
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("Sick Date : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13
                          ),
                        ),
                        Expanded(
                          child: Text(sickDate ?? '-',
                            style: TextStyle(
                              fontSize: 13
                            ),
                          )
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Icon(Icons.cancel_outlined, color: Colors.red,),
                        SizedBox(width: 10,),
                        Text("Rejected by : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13
                          ),
                        ),
                        Expanded(
                          child: Text(getUserDetail.approvedBy,
                            style: TextStyle(
                              fontSize: 13
                            ),
                          )
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.calendar_month_sharp, color: Colors.red,),
                        SizedBox(width: 10,),
                        Text("Rejected Date : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13
                          ),
                        ),
                        Expanded(
                          child: Text(approvedDate ?? '-',
                            style: TextStyle(
                              fontSize: 13
                            ),
                          )
                        )
                      ],
                    ),

                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.book, color: Colors.red,),
                        SizedBox(width: 10,),
                        Text("Reason Rejected : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13
                          ),
                        ),
                        Expanded(
                          child: Text(getUserDetail.rejectedReason,
                            style: TextStyle(
                              fontSize: 13
                            ),
                          )
                        )
                      ],
                    ),
                  ],
                ),
              )
            ),
            SizedBox(height: 40,),
            Container(
              margin: EdgeInsets.all(10),
              width: 250,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text("This request has been Rejected",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ), 
                  ),
                )
              )
            ),
          ],
        ),
      )
    );
  }
}