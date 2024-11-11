import 'package:absent_project/approvalls/lembur/msdo/ApprovedDetail.dart';
import 'package:absent_project/approvalls/lembur/msdo/DetailLemburUser.dart';
import 'package:absent_project/approvalls/lembur/msdo/RejectedDetail.dart';
import 'package:absent_project/approvalls/lembur/msdo/pengajuan_lembur.dart';
import 'package:absent_project/controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertimeGetStatusModel.dart';
import 'package:absent_project/controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertimeModel.dart';
import 'package:absent_project/controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertmaControlleri.dart';
import 'package:absent_project/home/ApplicationBar.dart';
// import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertimeGetProjectModel.dart';
// import 'package:intl/intl.dart';

class ListUserLembur extends StatefulWidget {
  const ListUserLembur({super.key});

  @override
  State<ListUserLembur> createState() => _ListUserLemburState();
}

// class Item {
//   final String title;
//   final DateTime dateTime;

//   Item({required this.title, required this.dateTime});
// }

class _ListUserLemburState extends State<ListUserLembur> {
  List<AdminApprovalOvertimeModel> getListUser = [];
  List<AdminApprovalOvertimeGetStatusModel> getStatus = [];
  List<AdminApprovalOvertimeGetProjectModel> getProject = [];

  String selectedProject = 'Project';
  String selectedStatus = 'Status';

  @override
  void initState() {
    super.initState();
    fetchOvertimeRequests();
    fetchStatusOT();
    fetchProjectOT();
  }

  Future<void> fetchOvertimeRequests() async {
    try {
      List<AdminApprovalOvertimeModel>? overtimeRequests =
          await AdminApprovalOvertimaController().getList();
      setState(() {
        getListUser = overtimeRequests!;
      });
    } catch (e) {
      // Handle errors or exceptions here
      print('Errorrr fetching overtime requests: $e');
    }
  }

  Future<void> fetchStatusOT() async {
    try {
      List<AdminApprovalOvertimeGetStatusModel>? statusList =
          await AdminApprovalOvertimaController().getStatus();

      setState(() {
        getStatus = statusList!;
      });
    } catch (e) {
      print('Error fetching overtime requests: $e');
    }
  }

  Future<void> fetchProjectOT() async {
    try {
      List<AdminApprovalOvertimeGetProjectModel>? projectList =
          await AdminApprovalOvertimaController().getProject();

      setState(() {
        getProject = projectList!;
      });
    } catch (e) {
      print('Error fetching overtime requests: $e');
    }
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

  List<AdminApprovalOvertimeModel> get filteredLembur {
    return getListUser.where((lembur) {
      final matchesStatus =
          selectedStatus == 'Status' || lembur.status == selectedStatus;
      final matchesProject =
          selectedProject == 'Project' || lembur.project == selectedProject;
      return matchesStatus && matchesProject;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.to(ApplicationBar(
          initialIndex: 3,
        ));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Overtime Approval MSDO Project",
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
                        return DropdownMenuItem(
                          child: Text(project.project),
                          value: project.project,
                        );
                      })
                    ]),
                SizedBox(
                  width: 20,
                ),
                DropdownButton<String>(
                    value: selectedStatus,
                    onChanged: (String? value) {
                      setState(() {
                        selectedStatus = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: "Status",
                        child: Text("Status"),
                      ),
                      ...getStatus.map((status) {
                        return DropdownMenuItem<String>(
                          value: status.status ?? '', // Use status value
                          child: Text(status.status ??
                              ''), // Display status in dropdown
                        );
                      }).toList(),
                    ]
                    /*filterStatus
                        .map<DropdownMenuItem<String>>(
                          (AdminApprovalOvertimeGetStatusModel status) =>
                          DropdownMenuItem<String>(
                            value: status.status,
                            child: Text(status.status),
                          ),
                    )
                        .toList(),*/
                    )
              ]),
            ),
            Expanded(
              child: ListView.builder(
                // itemCount: requests.length,
                itemCount: filteredLembur.length,
                itemBuilder: (context, index) {
                  // final request = requests[index];
                  final getData = filteredLembur[index];
                  final statusColor =
                      _getStatusColor(getData.status ?? "Unknown");
                  return GestureDetector(
                      onTap: () {
                        //  Get.to(() => DetailLemburUser(getData: getData));
                        if (getData.status == "New") {
                          Get.to(() => DetailLemburUser(getData: getData));
                        } else if (getData.status == "Approved") {
                          Get.to(() => ApprovedDetail(getData: getData));
                        } else if (getData.status == "Rejected") {
                          Get.to(() => RejectedDetail(getData: getData));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 350,
                        // height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(width: 0.5, color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 20, top: 15, right: 20),
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
                                      color: statusColor,
                                    ),
                                    height: 20,
                                    width: 80,
                                    child: Center(
                                      child: Text(
                                        getData.status ?? "New",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
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
                                'assets/images/workaholism.png',
                              )),
                              title: Text(
                                "Overtime Request",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        style:
                                            TextStyle(fontSize: 12, height: 2),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        getData.full_name,
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.blue),
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
                                        style:
                                            TextStyle(fontSize: 12, height: 2),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        getData.project,
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.blue),
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
                                        getData.submittedDate,
                                        style: TextStyle(fontSize: 12),
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
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const PengajuanLembur());
          },
          backgroundColor: const Color.fromARGB(255, 98, 171, 232),
          elevation: 5,
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
