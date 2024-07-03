import 'package:flutter/cupertino.dart';
import 'package:absent_project/controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertimeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:absent_project/approvalls/lembur/GeneratePDF.dart';
import 'package:printing/printing.dart';

class RejectedDetail extends StatefulWidget {
  final AdminApprovalOvertimeModel getData;
  const RejectedDetail({super.key,
  required this.getData});

  @override
  State<RejectedDetail> createState() => _RejectedDetailState();
}

class _RejectedDetailState extends State<RejectedDetail> {
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
                      widget.getData.status,
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
                    Text(widget.getData.reqNo,
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
                    Text(widget.getData.submittedDate,
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
              // height: 380,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
                border: Border.all(width: 0.5, color: Colors.grey),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 20),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  widget.getData.full_name,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),  // Adjust this width as needed
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Location",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget.getData.location,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  widget.getData.position,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),  // Adjust this width as needed
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
                                  widget.getData.department,
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
                                Text("Overtime Date",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(widget.getData.start_date,
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
                                Text("Shift",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(widget.getData.shift,
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
                        Text("Reason of Overtime : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13
                          ),
                        ),
                        Text(widget.getData.activity,
                          style: TextStyle(
                            fontSize: 13
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text("Overtime Hours ",
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
                              widget.getData.start_time,
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
                              widget.getData.end_time,
                              style: TextStyle(
                                fontSize: 13
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text("Your request has been Rejected",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11
                  ), 
                ),
              )
            ),
            Container(
              height: 80,
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                color: Colors.white
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reason :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "gak gak boleh, hayo maw kemana",
                    ),
                  ],
                )
              )
            )
          ],
        ),
      )
    );
  }
}