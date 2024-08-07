import 'dart:io';

import 'package:absent_project/approvalls/lembur/user/pengajuan_lembur.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeGetListModel.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
  }


  Future<void> fetchOvertimeRequests() async {
    try {
      List<MemberRequestOvertimeGetListModel>? overtimeRequests =
          await MemberRequestOvertimeController().getList();
      setState(() {
        getListUser = overtimeRequests!;
      });
    } catch (e) {
      // Handle errors or exceptions here
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

  /*List<MemberRequestOvertimeGetListModel> get filteredLembur {
    if (getStatus.isEmpty ||
        getStatus.every((status) => !status.selected)) {
      return getListUser; // Return all data when no filters are selected
    }

    List<String> selectedStatus = getStatus
        .where((status) => status.selected)
        .map((status) => status.status)
        .toList();
    return getListUser
        .where((lembur) => selectedStatus.contains(lembur.status))
        .toList();
  }*/

  /*List<Map<String, String>> get filteredLembur {
    if (filterStatus == "All") {
      return userlembur;
    }
    return userlembur
        .where((lembur) => lembur['status'] == filterStatus)
        .toList();
  }*/

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
                  leading: status.status == "New" ? Icon(Icons.new_releases)
                  : status.status == "Approved" ? Icon(Icons.done)
                      : status.status == "Rejected" ? Icon(Icons.dnd_forwardslash)
                  : null,
                  title: Text(status.status),
                  onTap: (){
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
  void _showDetail(BuildContext context, MemberRequestOvertimeGetListModel getSelected) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              // height: 200,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Detail Overtime",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    // thickness: 1
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Status ", style: TextStyle(fontSize: 15)),
                            Text("Description ", style: TextStyle(fontSize: 15))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(": "),
                            Text(": "),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getSelected.status),
                              if(getSelected.status == "Rejected")
                                Text(getSelected.reason_rejected)
                              else
                                Text(getSelected.activity),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List Overtime Request",
          style: TextStyle(fontSize: 15),
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
          //FILTER LAMA
          /*
          Container(
            width: 325,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*  FilterChip(
                    label: Text(),
                    selected: filterStatus.isEmpty || filterStatus.every((status) => !status.selected),
                    onSelected: (bool selected) {
                      setState(() {
                        filterStatus.forEach((status) => status.selected = true);
                      });
                    },
                  ),*/
                  ...filterStatus.map((status) => FilterChip(
                        label: Text(status.status),
                        selected: status.selected,
                        onSelected: (bool selected) {
                          setState(() {
                            status.selected = !status.selected;
                          });
                        },
                      ))
                ],
              ),
            ),
          ),
          */
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
                /*
                final getData = filteredLembur[index];
                */

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
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/overtime.png',
                          scale: 5,
                        ),
                        title: Text(
                          /*getData.activity,
                          */

                          getData.activity,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_month),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  /* getData.start_date,
                                  */

                                  getData.start_date,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.supervised_user_circle_outlined),
                                SizedBox(width: 5),
                                Text(
                                  /* getData.full_name,
                                  */

                                  getData.full_name,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                              ],
                            )
                          ],
                        ),
                        trailing: Text(
                          /* getData.status,
                          */

                          getData.status,
                          /*
                          style: TextStyle(
                              color: getData.status == 'Approved'
                                  ? Colors.green
                                  : getData.status == 'New'
                                      ? Colors.blue
                                      : Colors.red,
                          */

                          style: TextStyle(
                              color: getData.status == 'Approved'
                                  ? Colors.green
                                  :getData.status == "New"
                                    ?Colors.blue
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
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => const PengajuanLembur());
            /* Get.to(() => const PengajuanLembur());
            */

            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PengajuanLembur()));
          },
          backgroundColor: Color.fromARGB(255, 98, 171, 232),
          child: Icon(Icons.edit),
          elevation: 5,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
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
