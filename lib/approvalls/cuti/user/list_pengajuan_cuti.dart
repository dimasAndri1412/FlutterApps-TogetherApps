import 'dart:async';

import 'package:absent_project/approvalls/cuti/user/pengajuan_cuti.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberListPaidLeave.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberStatusPaidLeave.dart';
import 'package:absent_project/home/applicationbar_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPengajuanCuti extends StatefulWidget {
  const ListPengajuanCuti({
    super.key,
  });

  @override
  State<ListPengajuanCuti> createState() => _ListPengajuanCutiState();
}

class _ListPengajuanCutiState extends State<ListPengajuanCuti> {
  final MemberRequestPaidLeaveController memberInfo =
      MemberRequestPaidLeaveController();
  List<MemberListPaidLeave> getListUser = [];
  List<MemberStatuspaidleave> getStatus = [];

  String defaultStatus = 'All';
  bool isButtonEnabled = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPaidLeaveRequest();
    fetchStatusPaidLeave();
  }

  void _checkDate(){
    final today = DateTime.now();
    if(today.day > 11){
      setState(() {
        isButtonEnabled = false;
      });
     _showWarningDialog();
    }else {
      setState(() {
        isButtonEnabled = true;
        Get.to(()=>const PengajuanCuti());
      });
    }
  }

  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Peringatan"),
          content: const Text("Silahkan ajukan cuti dari tanggal 1 - 11"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchPaidLeaveRequest() async {
    try {
      List<MemberListPaidLeave>? paidLeaveRequest =
          await MemberRequestPaidLeaveController().getList();
      setState(() {
        getListUser = paidLeaveRequest!;
      });
    } catch (e) {
      print('Error fetching overtime requests: $e');
    }
  }

  Future<void> fetchStatusPaidLeave() async {
    try {
      List<MemberStatuspaidleave>? statusList =
          await MemberRequestPaidLeaveController().getStatus();
      setState(() {
        getStatus = statusList ?? [];
      });
    } catch (e) {
      print('Error fetching overtime requests: $e');
    }
  }

  List<MemberListPaidLeave> get filteredCuti {
    return getListUser.where((cuti) {
      final matchesStatus =
          defaultStatus == 'All' || cuti.status == defaultStatus;
      return matchesStatus;
    }).toList();
  }

  //Function Filter Alert Dialog
  void _showFilterOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            'Select Filter',
            style: TextStyle(fontWeight: FontWeight.w500),
          )),
          content: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.select_all),
                  title: const Text('All'),
                  onTap: () {
                    setState(() {
                      defaultStatus = 'All';
                    });
                    Navigator.pop(context);
                  },
                ),
                ...getStatus.map((status) => ListTile(
                      leading: status.status == "New"
                          ? const Icon(Icons.new_releases)
                          : status.status == "Approved"
                              ? const Icon(Icons.done)
                              : status.status == "Rejected"
                                  ? const Icon(Icons.dnd_forwardslash)
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

  //function detail cuti
  void _showDetail(BuildContext context, MemberListPaidLeave getSelected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          contentPadding: const EdgeInsets.only(top: 10.0),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Detail Paid Leave",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              const Divider(color: Colors.grey),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Table(
                  // Set border to null for transparent lines
                  border: const TableBorder(
                    horizontalInside: BorderSide.none,
                    verticalInside: BorderSide.none,
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(0.5),
                    2: FlexColumnWidth(3),
                  },
                  children: [
                    // Row for Status
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child:
                              Text("Status", style: TextStyle(fontSize: 15)),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(":", style: TextStyle(fontSize: 15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(getSelected.status,
                              style: const TextStyle(fontSize: 15)),
                        ),
                      ],
                    ),
                    // Row for Description / Reason
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Description",
                              style: TextStyle(fontSize: 15)),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(":", style: TextStyle(fontSize: 15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            getSelected.status == 'Rejected'
                                ? getSelected.reason_rejected
                                : getSelected.reason_leave,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Days", style: TextStyle(fontSize: 15)),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(":", style: TextStyle(fontSize: 15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            getSelected.jumlah_hari,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                      bottomRight: Radius.circular(32.0),
                    ),
                  ),
                  child: const Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (context, result) {
      //   Get.to(ApprovallsUser());
      // },
      onPopInvoked: (didPop) {
        Get.to(const ApplicationBarUser());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "List Paid Leave Request",
              style: TextStyle(fontSize: 15),
            ),
          ),
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 0),
              child: Container(
                width: 500,
                // height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 147, 195, 234),
                          blurRadius: 5,
                          offset: Offset(0, 0))
                    ]),
                /////////
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Leave Statistics",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 2),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Column(
                            children: [
                              Icon(Icons.offline_bolt_outlined),
                              Icon(Icons.offline_bolt_outlined),
                            ],
                          ),
                          const Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Leave Used"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Remaining Leave")
                              ]),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(":"),
                              SizedBox(
                                height: 5,
                              ),
                              Text(":"),
                            ],
                          ),
                          // FutureBuilder(
                          FutureBuilder/*<List<UserListPaidLeave>?>*/(
                              // future: memberInfo.getLeave(),
                              future: memberInfo.getLeaveNew(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text("Error: ${snapshot.error}");
                                  // } else if (!snapshot.hasData ||
                                  //     snapshot.data!.isEmpty) {
                                  //   return Text("No Data Available");
                                } else {
                                  //
                                  // var user = snapshot.data!.first;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text("${memberInfo.leaveUsed}"),
                                      // Text("${user.leave_used}"),
                                      Text("${memberInfo.leaveUsed}"),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Text("${memberInfo.initial}"),
                                      // Text("${user.remaining_leave}"),
                                      Text("${memberInfo.remainingLeave}"),
                                    ],
                                  );
                                }
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => _showFilterOptions(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.only(left: 15, top: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Filter: $defaultStatus',
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // FutureBuilder(
            //     future: MemberRequestPaidLeaveController().getList(),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const CircularProgressIndicator();
            //       } else if (snapshot.hasError) {
            //         return const Text("");
            //       } else {
            // return
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ListView.builder(
                itemCount: filteredCuti.length,
                itemBuilder: (context, index) {
                  //panggil usercuti sebagai cutiisi
                  /*var getUser = snapshot.data![index];*/
                  // final isicuti = filteredCuti[index];
                  final memberInfo = filteredCuti[index];

                  return GestureDetector(
                    onTap: () => _showDetail(context, memberInfo),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 0.5, color: Colors.grey)),
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/job.png',
                            scale: 5,
                          ),
                          title: Text(
                            /*getUser.reasonLeave,*/
                            // isicuti['reason']!,
                            memberInfo.reason_leave,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    /*getUser.startDateLeave,*/
                                    // isicuti['date']!,
                                    memberInfo.date_start_leave,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text("-"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    memberInfo.date_end_leave,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.offline_bolt_outlined),
                                  const SizedBox(width: 5),
                                  Text(
                                    /*getUser.name,*/
                                    // isicuti['name']!,
                                    memberInfo.jumlah_hari,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                ],
                              )
                            ],
                          ),
                          trailing: Text(
                            /*getUser.status,*/
                            // usercuti[index]['status']!,
                            memberInfo.status,

                            style: TextStyle(
                                /*color: getUser.status== 'new'*/
                                // color: isicuti['status'] == 'Approved'
                                color: memberInfo.status == 'Approved'
                                    ? Colors.green
                                    // : isicuti['status'] == 'New'
                                    : memberInfo.status == 'New'
                                        ? Colors.blue
                                        : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
                // )
                )
            // ;
            // }
            // }
            // )
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: FloatingActionButton(
            onPressed: _checkDate,
            backgroundColor: const Color.fromARGB(255, 98, 171, 232),
            elevation: 5,
            child: const Icon(Icons.edit),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
      ),
    );
  }

  // void downloadFile() async {
  //   var time = DateTime.now().millisecondsSinceEpoch;
  //   var path = "/storage/emulated/0/Download/images-$time.jpg";
  //   var file = File(path);
  //   var res = await get(Uri.parse("https://source.unsplash.com/random"));
  //   file.writeAsBytes(res.bodyBytes);
  // }
}
