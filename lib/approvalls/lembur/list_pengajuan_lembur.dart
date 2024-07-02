import 'dart:io';

import 'package:absent_project/approvalls/lembur/pengajuan_lembur.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeGetListModel.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeController.dart';
import '../../controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeGetStatusModel.dart';

class ListPengajuanLembur extends StatefulWidget {
  const ListPengajuanLembur({super.key});

  @override
  State<ListPengajuanLembur> createState() => _ListPengajuanLemburState();
}

class _ListPengajuanLemburState extends State<ListPengajuanLembur> {



  @override
  void initState() {
    super.initState();
    fetchOvertimeRequests();
    fetchStatusOT();
}
  List<MemberRequestOvertimeGetListModel> userlembur = [];
  Future<void> fetchOvertimeRequests() async {
    try {
      List<MemberRequestOvertimeGetListModel>? overtimeRequests =
      await MemberRequestOvertimeController().getList();
      setState(() {
        userlembur = overtimeRequests!;
      });
    } catch (e) {
      // Handle errors or exceptions here
      print('Error fetching overtime requests: $e');
    }
  }


  List<MemberRequestOvertimeGetStatusModel> filterStatus = [];
  Future<void> fetchStatusOT() async {
    try {
      List<MemberRequestOvertimeGetStatusModel>? statusList =
      await MemberRequestOvertimeController().getStatus();

      setState(() {
        filterStatus = statusList ?? []; // Include 'All' option
      });
    } catch (e) {
      print('Error fetching overtime requests: $e');
    }
  }
  //untuk membuat filter All, Approved, Rejected
  //String filterStatus = 'All';

  List<MemberRequestOvertimeGetListModel> get filteredLembur {
    if (filterStatus.isEmpty || filterStatus.every((status) => !status.selected)) {
      return userlembur; // Return all data when no filters are selected
    }

    List<String> selectedStatus =
        filterStatus.where((status) => status.selected)
            .map((status) => status.status)
            .toList();
    return userlembur
        .where((lembur) => selectedStatus.contains(lembur.status))
        .toList();
  }


  String chooseStatus = "";
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
          //FILTER
          Container(
            // color: Colors.grey,
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
                      onSelected: (bool selected){
                        setState(() {
                          status.selected = !status.selected;
                        });
                      },
                  ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
                    child: ListView.builder(
                      // itemCount: userlembur.length,
                      itemCount: filteredLembur.length,
                      itemBuilder: (context, index) {
                        final getData = filteredLembur[index];
                        // final isilembur = userlembur[index];
                        //final isilembur = filteredLembur[index];

                        return Padding(
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
                                getData.activity,
                                //dipakai jika tanpa final cutiisi
                                // usercuti[index]['name']!,
                                //isilembur['reason']!,
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
                                        getData.start_date,
                                        //isilembur['date']!,
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.supervised_user_circle_outlined),
                                      SizedBox(width: 5),
                                      Text(
                                        getData.full_name,
                                        //isilembur['name']!,
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 10),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              trailing: Text(
                                getData.status,
                                //isilembur['status']!,
                                style: TextStyle(
                                    color: getData.status == 'Approved'
                                        ? Colors.green
                                        : getData.status == 'New'
                                        ? Colors.blue
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
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
            /*Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PengajuanLembur()));*/
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
