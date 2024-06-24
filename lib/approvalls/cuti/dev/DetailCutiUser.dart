import 'package:absent_project/controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeaveController.dart';
import 'package:absent_project/controller/ApprovalController/AdminApprovalPaidLeave/adminGetDetail.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/approvalls/cuti/GeneratePDF_Development.dart';
import 'package:absent_project/approvalls/cuti/dev/ConfirmationDialog.dart';
// import 'pdf_generator.dart';
// import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
// import 'package:pdf/pdf.dart';
// import 'package:barcode/barcode.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

import '../../../controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeave_Development.dart';
import '../../../controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';


class DetailCutiUser extends StatelessWidget {
  final AdminApprovalPaidLeave_Development getUserDetail;
  DetailCutiUser({super.key,
    required this.getUserDetail});

  @override
  Widget build(BuildContext context) {
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
      body:/* FutureBuilder(
          future: getDetail.getDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }else {
              return */Column(
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
                            Icon(Icons.notifications_active,
                              color: Colors.orange,),
                            SizedBox(width: 5,),
                            Text(
                              "Status : ",
                            ),
                            Text(
                              getUserDetail.status,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 5, left: 20, right: 20, bottom: 10),
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 152, 188, 210).withOpacity(
                            0.2),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Text(getUserDetail.reqNo,
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
                              Text(getUserDetail.submittedDate,
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
                        height: 450,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(width: 0.5, color: Colors.grey),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 15, left: 20, right: 20),
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
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("Submitted by",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(getUserDetail.username,
                                        style: TextStyle(
                                            fontSize: 13
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 100,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("Phone Number",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(getUserDetail.phoneNumber,
                                        style: TextStyle(
                                            fontSize: 13
                                        ),
                                      )
                                    ],
                                  ),
                                ],
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("Position",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(getUserDetail.position,
                                        style: TextStyle(
                                            fontSize: 13
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 80,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("Department",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(getUserDetail.departement,
                                        style: TextStyle(
                                            fontSize: 13
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                                indent: 2,
                                endIndent: 2,
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("Leave Type",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(getUserDetail.types_leave,
                                        style: TextStyle(
                                            fontSize: 13
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 100,),
                                  /*Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("Shift",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text("1",
                                        style: TextStyle(
                                            fontSize: 13
                                        ),
                                      )
                                    ],
                                  ),*/
                                ],
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
                                  Text("Reason of Leave : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13
                                    ),
                                  ),
                                  Text(getUserDetail.reason_leave,
                                    style: TextStyle(
                                        fontSize: 13
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5,),
                              Text("Leave Date ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13
                                ),
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Container(
                                    width: 140,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)
                                    ),
                                    child: Center(
                                      child: Text(
                                        getUserDetail.date,
                                        style: TextStyle(
                                            fontSize: 13
                                        ),
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
                                        border: Border.all(color: Colors.grey)
                                    ),
                                    child: Center(
                                      child: Text(
                                        getUserDetail.date_end_leave,
                                        style: TextStyle(
                                            fontSize: 13
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text("Name Of PIC : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13
                                    ),
                                  ),
                                  Text(getUserDetail.name_of_pic,
                                    style: TextStyle(
                                        fontSize: 13
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text("Will return to work on : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13
                                    ),
                                  ),
                                  Text(getUserDetail.date_back_to_work,
                                    style: TextStyle(
                                        fontSize: 13
                                    ),
                                  )

                                ],
                              ),
                            ],
                          ),
                        )
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            width: 165,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Center(
                              child: Text(
                                "Reject",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              print("Click event on Container");
                              // Navigator.of(context)
                              // .push(MaterialPageRoute(builder: (context) => GeneratePDF()));
                              // Generate the PDF with a barcode
                              // final backgroundImage = await loadImage('assets/images/BIT-Logo.png');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmationDialog(getUserDetail: getUserDetail,);
                                },
                              );

                              // final pdf = await PDFGenerator_Development(getUserDetail: getUserDetail,).GeneratePDF();
                              // await Printing.layoutPdf(
                              //     onLayout: (format) => pdf);
                            },
                            child: Container(
                              width: 165,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: Center(
                                child: Text(
                                  "Approve",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
/*          }
          }
    )*/
    );
  }
}