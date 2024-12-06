import 'dart:io';

import 'package:absent_project/approvalls/lembur/msdo/pengajuan_lembur.dart';
import 'package:absent_project/approvalls/lembur/user/GeneratePDFuser.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeGetListModel.dart';
import 'package:absent_project/controller/ApprovalController/NotificationProvider.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/home/applicationbar_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../../controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeController.dart';
import '../../../controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeGetStatusModel.dart';

class ListPengajuanLembur extends StatefulWidget {
  const ListPengajuanLembur({super.key});

  @override
  State<ListPengajuanLembur> createState() => _ListPengajuanLemburState();
}

class _ListPengajuanLemburState extends State<ListPengajuanLembur> {
  List<MemberRequestOvertimeGetListModel> getListUser = [];
  List<MemberRequestOvertimeGetStatusModel> getStatus = [];

  String defaultStatus = 'All';

  @override
  void initState() {
    super.initState();
    fetchOvertimeRequests();
    fetchStatusOT();
    // checkApprovedOvertime();
  }

  Future<void> fetchOvertimeRequests() async {
    try {
      List<MemberRequestOvertimeGetListModel>? overtimeRequests =
          await MemberRequestOvertimeController().getList();
      // if (overtimeRequests != null && overtimeRequests.isNotEmpty) {
      setState(() {
        getListUser = overtimeRequests!;
      });

      // Check for approved requests
      // List<MemberRequestOvertimeGetListModel> approvedRequests = getListUser
      //     .where((request) => request.status == 'Approved')
      //     .toList();

      // if (approvedRequests.isNotEmpty) {
      //   for (var request in approvedRequests) {
      //     context.read<NotificationProvider>().addNotification(
      //         "New Overtime Request Approved (${request.reqNo})", "overtime");
      //   }
      // }
      // } else {
      //   print("No overtime requests found");
      // }
    } catch (e) {
      print('Error fetching overtime requests: $e');
    }
  }

  Future<void> fetchStatusOT() async {
    try {
      List<MemberRequestOvertimeGetStatusModel>? statusList =
          await MemberRequestOvertimeController().getStatus();

      setState(() {
        getStatus = statusList ?? []; // Include 'All' option
      });
    } catch (e) {
      print('Error fetching overtime requests: $e');
    }
  }

  List<MemberRequestOvertimeGetListModel> get filteredLembur {
    return getListUser.where((lembur) {
      final matchesStatus =
          defaultStatus == 'All' || lembur.status == defaultStatus;
      return matchesStatus;
    }).toList();
  }

  //Function Filter Alert Dialog
  void _showFilterOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Select Filter',
            style: TextStyle(fontWeight: FontWeight.w500),
          )),
          content: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(),
                ListTile(
                  leading: Icon(Icons.select_all),
                  title: Text('All'),
                  onTap: () {
                    setState(() {
                      defaultStatus = 'All';
                    });
                    Navigator.pop(context);
                  },
                ),
                ...getStatus.map((status) => ListTile(
                      leading: status.status == "New"
                          ? Icon(Icons.new_releases)
                          : status.status == "Approved"
                              ? Icon(Icons.done)
                              : status.status == "Rejected"
                                  ? Icon(Icons.dnd_forwardslash)
                                  : null,
                      title: Text(status.status),
                      onTap: () {
                        setState(() {
                          defaultStatus = status.status;
                        });
                        Navigator.pop(context);
                      },
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  //function detail lembur
  void _showDetail(
      BuildContext context, MemberRequestOvertimeGetListModel getSelected) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text(
                    "Detail Approval",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 147, 195, 234),
                      Color.fromARGB(255, 98, 171, 232),
                      Color.fromARGB(255, 123, 185, 235),
                    ]),
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
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.new_releases,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Status : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              getSelected.status,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
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
                        color:
                            Color.fromARGB(255, 152, 188, 210).withOpacity(0.2),
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
                              Text(
                                getSelected.reqNo,
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "Submitted Date ",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                getSelected.submittedDate,
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )),
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
                          padding: EdgeInsets.only(
                              top: 15, left: 20, right: 20, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Request Detail",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                                indent: 2,
                                endIndent: 2,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Submitted by",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            getSelected.full_name,
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            20), // Adjust this width as needed
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Location",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            getSelected.location,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Position",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            getSelected.position,
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            20), // Adjust this width as needed
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Department",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            getSelected.department,
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
                              SizedBox(
                                height: 5,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Overtime Date",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            getSelected.start_date,
                                            style: TextStyle(fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Shift",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            getSelected.shift,
                                            style: TextStyle(fontSize: 13),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                                indent: 2,
                                endIndent: 2,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Reason of Overtime : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    getSelected.activity,
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Overtime Hours :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 140,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    child: Center(
                                      child: Text(
                                        getSelected.start_time,
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
                                        border: Border.all(color: Colors.grey)),
                                    child: Center(
                                      child: Text(
                                        getSelected.end_time,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Column(
                                  children: [
                                    Text("Approved By",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 18)),
                                    Text(getSelected.approved_by,
                                        style: TextStyle(fontSize: 15))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Your request has been Approved",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          final pdf = await GeneratePDFOvertimeUser(
                                  getData: getSelected)
                              .GeneratePDF();
                          await Printing.layoutPdf(onLayout: (format) => pdf);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.print, color: Colors.green[300]),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Print Document',
                              style: TextStyle(color: Colors.green[300]),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.green, width: 2.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 80.0, vertical: 12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(ApplicationBarUser(initialIndex: 3));
            },
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
            )),
        title: Text(
          "List Overtime Request",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 147, 195, 234),
              Color.fromARGB(255, 98, 171, 232),
              Color.fromARGB(255, 123, 185, 235),
            ]),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0,
          ),
          GestureDetector(
            onTap: () => _showFilterOptions(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(left: 15, top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filter: $defaultStatus',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLembur.length,
              itemBuilder: (context, index) {
                final getData = filteredLembur[index];

                return GestureDetector(
                  onTap: () => _showDetail(context, getData),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 0.5, color: Colors.grey)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 15, right: 20),
                            child: Row(
                              children: [
                                Text(
                                  "No. Req : ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(getData.reqNo),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.green),
                                  height: 20,
                                  width: 80,
                                  child: Center(
                                    child: Text(
                                      getData.status,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                            indent: 20,
                            endIndent: 20,
                          ),
                          ListTile(
                            leading: CircleAvatar(
                                backgroundImage: AssetImage(
                              'assets/images/workaholism.png',
                            )),
                            title: Text(
                              getData.activity,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Icon(
                                    Icons.people_alt_outlined,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 5),
                                  Text("Approved by ",
                                      style:
                                          TextStyle(fontSize: 12, height: 2)),
                                  SizedBox(width: 3),
                                  Text(getData.approved_by,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ]),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      getData.start_date,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      getData.start_time,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text("-"),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      getData.end_time,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
