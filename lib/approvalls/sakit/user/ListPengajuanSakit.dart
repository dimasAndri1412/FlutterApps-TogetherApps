import 'package:absent_project/approvalls/sakit/user/FormPengajuanSakit.dart';
import 'package:absent_project/controller/ApprovalController/SickLeaveController/Member/MemberSickLeaveController.dart';
import 'package:absent_project/home/applicationbar_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListPengajuanSakit extends StatefulWidget {
  const ListPengajuanSakit({super.key});

  @override
  State<ListPengajuanSakit> createState() => _ListPengajuanSakitState();
}

class _ListPengajuanSakitState extends State<ListPengajuanSakit> {

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'New':
        return Colors.blue;
      default:
        return Colors.blue; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(ApplicationBarUser(
                initialIndex: 3,
              ));
            },
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
            )),
        title:Text(
            "Sick Approval",
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
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            FutureBuilder(
              future: MemberSickLeaveController().getList(),
              builder: (context, snapshot) {
                print("Snapshot data: ${snapshot.data}");
                if (snapshot.data == null) {
                  return const Center(
                      child: Text("There is no request need to approve"));
                } else {
                  // var filteredData = snapshot.data!.where((data) {
                  //   bool matchesProject = selectedProject == 'Project' ||
                  //       data.project == selectedProject;
                  //   bool matchesStatus = selectedStatus == 'Status' ||
                  //       data.status == selectedStatus;
                  //   return matchesProject && matchesStatus;
                  // }).toList();
                  final data = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      // itemCount: snapshot.data?.length,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        // final getData = snapshot.data![index];
                        final getData = data[index];
                        final statusColor =
                            _getStatusColor(getData.status ?? "Unknown");

                        String? formattedDate = getData.date != null ? DateFormat('dd MMM yyyy').format(getData.date!) : null;
                        
                        return GestureDetector(
                            onTap: () {
                              // // Get.to(() => DetailCutiUser(getUserDetail: getData,));
                              // if (getData.status == "New") {
                              //   Get.to(() =>
                              //       DetailCutiUser(getUserDetail: getData));
                              // } else if (getData.status == "Approved") {
                              //   Get.to(() =>
                              //       ApprovedDetail(getUserDetail: getData));
                              // } else if (getData.status == "Rejected") {
                              //   Get.to(() =>
                              //       RejectedDetail(getUserDetail: getData));
                              // }
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
                                              Icons.sick,
                                              size: 18,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Sick type",
                                              style: TextStyle(
                                                  fontSize: 12, height: 2),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Expanded(
                                              child : Text(
                                                getData.note,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.blue),
                                                softWrap: true, // Membungkus teks
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
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
                                             formattedDate ?? "-",
                                              style:
                                              TextStyle(fontSize: 12),
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
                                              "Approved by",
                                              style: TextStyle(
                                                  fontSize: 12, height: 2),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              getData.approvedBy,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blue),
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
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FormPengajuanSakit()),
          );
        },
        backgroundColor: Colors.blue[600],
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}