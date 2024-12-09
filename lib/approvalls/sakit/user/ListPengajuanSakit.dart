import 'package:absent_project/approvalls/sakit/user/ApprovedDetail.dart';
import 'package:absent_project/approvalls/sakit/user/DetailPengajuan.dart';
import 'package:absent_project/approvalls/sakit/user/FormPengajuanSakit.dart';
import 'package:absent_project/approvalls/sakit/user/RejectedDetail.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeController.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeGetStatusModel.dart';
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
  List<MemberRequestOvertimeGetStatusModel> getStatus = [];
  String defaultStatus = 'All';

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
  void initState() {
    super.initState();
    fetchStatusOT();
  }

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

  Future<void> fetchStatusOT() async {
    try {
      List<MemberRequestOvertimeGetStatusModel>? statusList =
          await MemberRequestOvertimeController().getStatus();

      setState(() {
        getStatus = statusList ?? [];
      });
    } catch (e) {
      print('Error fetching overtime requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.to(ApplicationBarUser(
          initialIndex: 3,
        ));
      },
      child: Scaffold(
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
          title: Text(
            "Sick Approval",
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                height: 20,
              ),
              FutureBuilder(
                  future: MemberSickLeaveController().getList(),
                  builder: (context, snapshot) {
                    print("Snapshot data: ${snapshot.data}");
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("You haven't made a request yet"),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("An error occurred while fetching data"),
                      );
                    } else {
                      final data = snapshot.data!;
                      final filteredData = defaultStatus == 'All'
                          ? data
                          : data
                              .where((data) => data.status == defaultStatus)
                              .toList();

                      if (filteredData.isEmpty) {
                        return Center(
                          child: Text("No data matches your filter criteria"),
                        );
                      }

                      return Expanded(
                        child: ListView.builder(
                          // itemCount: snapshot.data?.length,
                          itemCount: filteredData.length,
                          itemBuilder: (context, index) {
                            // final getData = snapshot.data![index];
                            final getData = filteredData[index];
                            final statusColor =
                                _getStatusColor(getData.status ?? "Unknown");

                            String? formattedDate = getData.date != null
                                ? DateFormat('dd MMM yyyy')
                                    .format(getData.date!)
                                : null;

                            return GestureDetector(
                                onTap: () {
                                  if (getData.status == "New") {
                                    Get.to(() => DetailPengajuan(
                                        getUserDetail: getData));
                                  } else if (getData.status == "Approved") {
                                    Get.to(() =>
                                        ApprovedDetail(getUserDetail: getData));
                                  } else if (getData.status == "Rejected") {
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
                                                  child: Text(
                                                    getData.note,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.blue),
                                                    softWrap:
                                                        true, // Membungkus teks
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                  getData.status == "Rejected"
                                                      ? "Rejected by"
                                                      : getData.status ==
                                                              "Approved"
                                                          ? "Approved by"
                                                          : "Status",
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
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FormPengajuanSakit()),
            );
          },
          backgroundColor: Colors.blue[600],
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
