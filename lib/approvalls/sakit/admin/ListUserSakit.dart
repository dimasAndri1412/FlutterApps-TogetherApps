// import 'dart:ffi';

import 'package:absent_project/approvalls/sakit/admin/ApprovedDetail.dart';
import 'package:absent_project/approvalls/sakit/admin/DetailUserSakit.dart';
import 'package:absent_project/approvalls/sakit/admin/RejectedDetail.dart';
import 'package:absent_project/controller/ApprovalController/SickLeaveController/Admin/AdminSickLeaveController.dart';
import 'package:absent_project/home/ApplicationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPadiLeaveGetStatusModel.dart';
import '../../../controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeaveController.dart';
import '../../../controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeaveGetProjectModel.dart';

class ListUserSakit extends StatefulWidget {
  const ListUserSakit({super.key});

  @override
  State<ListUserSakit> createState() => _ListUserSakitState();
}

class _ListUserSakitState extends State<ListUserSakit> {
  List<AdminApprovalPadiLeaveGetStatusModel> getStatus = [];
  List<AdminApprovalPaidLeaveGetProjectModel> getProject = [];

  String selectedProject = 'Project';
  String selectedStatus = 'Status';

  @override
  void initState() {
    super.initState();
    fetchStatusOT();
    fetchProjectOT();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'New':
        return Colors.blue;
      default:
        return Colors.blue; // Default color if status is unknown
    }
  }

  Future<void> fetchStatusOT() async {
    try {
      List<AdminApprovalPadiLeaveGetStatusModel>? statusList =
          await AdminApprovalPaidLeaveController().getStatus();

      setState(() {
        getStatus = statusList!;
      });
    } catch (e) {
      print('Error fetching paid leave requests: $e');
    }
  }

  Future<void> fetchProjectOT() async {
    try {
      List<AdminApprovalPaidLeaveGetProjectModel>? projectList =
          await AdminApprovalPaidLeaveController().getProject();

      setState(() {
        getProject = projectList!;
      });
    } catch (e) {
      print('Error fetching Status requests: $e');
    }
  }

  final List<String> project = [
    'Project',
    'MSDO Project',
    'Development Project'
  ];
  final List<String> status = ['Status', 'New', 'Approved', 'Rejected'];

  @override
  Widget build(BuildContext context) {
    // List<Map<String, String>> filteredRequests = selectedStatus == null
    //     ? requests
    //     : requests.where((request) => request['status'] == selectedStatus).toList();
    // String dropdownProject = project.first;
    // String dropdownStatus = status.first;

    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (context, result) {
      //   Get.to(ApprovallsUser());
      // },
      onPopInvoked: (didPop) {
        Get.to(ApplicationBar(
          initialIndex: 3,
        ));
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.to(ApplicationBar(
                    initialIndex: 3,
                  ));
                },
                icon: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.white,
                )),
            title: 
              Text(
                "Sick Leave Approval",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "Filter by :",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(children: [
                  DropdownButton<String>(
                      value: selectedProject,
                      onChanged: (String? value) {
                        setState(() {
                          selectedProject = value!;
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: "Project",
                          child: Text("Project"),
                        ),
                        ...getProject.map((project) {
                          return DropdownMenuItem<String>(
                              value: project.project,
                              child: Text(project.project));
                        }).toList()
                      ]),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                      value: selectedStatus,
                      onChanged: (String? value) {
                        setState(() {
                          selectedStatus = value!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                            value: "Status", child: Text("Status")),
                        ...getStatus.map((status) {
                          return DropdownMenuItem(
                              value: status.status, child: Text(status.status));
                        }).toList()
                      ])
                ]),
              ),
              FutureBuilder(
                  future: AdminSickLeaveController().getUsers(),
                  builder: (context, snapshot) {
                    // print("Snapshot data: ${snapshot.data}");
                    if (snapshot.data == null) {
                      return const Center(
                          child: Text("There is no request need to approve"));
                    } else {
                      var filteredData = snapshot.data!.where((data) {
                        bool matchesProject = selectedProject == 'Project' ||
                            data.projectName == selectedProject;
                        bool matchesStatus = selectedStatus == 'Status' ||
                            data.status == selectedStatus;
                        return matchesProject && matchesStatus;
                      }).toList();

                      return Expanded(
                        child: ListView.builder(
                          // itemCount: snapshot.data?.length,
                          itemCount: filteredData.length,
                          itemBuilder: (context, index) {
                            // final getData = snapshot.data![index];
                            final getData = filteredData[index];
                            final statusColor =
                                _getStatusColor(getData.status ?? "Unknown");
                            String? formattedDate = getData.date != null ? DateFormat('dd MMM yyyy').format(getData.date!) : null;
                            return GestureDetector(
                                onTap: () {
                                  // Get.to(() => DetailCutiUser(getUserDetail: getData,));
                                  if (getData.status == "New") {
                                    Get.to(() =>
                                        DetailUserSakit(getUserDetail: getData));
                                  } else if (getData.status == "Approved") {
                                    Get.to(() =>
                                        ApprovedDetail(getUserDetail: getData));
                                  } 
                                  else if (getData.status == "Rejected") {
                                    Get.to(() =>
                                        RejectedDetail(getUserDetail: getData));
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  width: 350,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(0),
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, top: 15, right: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              "No. Req : ",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Text("REQ-${getData.reqId}"),
                                            Spacer(),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: statusColor,
                                              ),
                                              height: 20,
                                              width: 80,
                                              child: Center(
                                                child: Text(
                                                  getData.status,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
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
                                          'assets/images/sick.png',
                                        )),
                                        title: Text(
                                          "Sick Leave Request",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.people_alt_outlined,
                                                  size: 18,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Submitted by",
                                                  style: TextStyle(
                                                      fontSize: 12, height: 2),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  getData.fullName,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.blue),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.people_alt_outlined,
                                                  size: 18,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Project",
                                                  style: TextStyle(
                                                      fontSize: 12, height: 2),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                 Expanded(
                                                  child: Text(
                                                    getData.projectName,
                                                    style: TextStyle(fontSize: 12, color: Colors.blue),
                                                    softWrap: true, // Membungkus teks
                                                    overflow: TextOverflow.ellipsis, // Tambahkan "..." jika terlalu panjang
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                                  formattedDate ?? '-',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        ),
                      );
                    }
                  }),
            ],
          )),
    );
  }
}
