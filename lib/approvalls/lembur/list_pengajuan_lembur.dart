import 'dart:io';

import 'package:absent_project/approvalls/lembur/pengajuan_lembur.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ListPengajuanLembur extends StatefulWidget {
  const ListPengajuanLembur({super.key});

  @override
  State<ListPengajuanLembur> createState() => _ListPengajuanLemburState();
}

class _ListPengajuanLemburState extends State<ListPengajuanLembur> {
  final List<Map<String, String>> userlembur = [
    {
      'name': 'Rogape',
      'reason': 'abie gak masuk karna cuti',
      'date': '2024-12-01',
      'status': 'Approved'
    },
    {
      'name': 'Rogape',
      'reason': 'febri pusing dan sakit',
      'date': '2024-12-02',
      'status': 'Approved'
    },
    {
      'name': 'Rogape',
      'reason': 'aves jalan - jalan ke Paris',
      'date': '2024-12-03',
      'status': 'Rejected'
    },
    {
      'name': 'Rogape',
      'reason': 'Kosong',
      'date': '2024-12-04',
      'status': 'Approved'
    },
  ];

  //untuk membuat filter All, Approved, Rejected
  String filterStatus = 'All';

  List<Map<String, String>> get filteredLembur {
    if (filterStatus == 'All') {
      return userlembur;
    }
    return userlembur
        .where((lembur) => lembur['status'] == filterStatus)
        .toList();
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
          //FILTER
          Container(
            // color: Colors.grey,
            width: 290,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterChip(
                    label: Text("All"),
                    selected: filterStatus == 'All',
                    onSelected: (bool selected) {
                      setState(() {
                        filterStatus = 'All';
                      });
                    },
                  ),
                  FilterChip(
                    label: Text("Approved"),
                    selected: filterStatus == 'Approved',
                    onSelected: (bool selected) {
                      setState(() {
                        filterStatus = selected ? 'Approved' : 'All';
                      });
                    },
                  ),
                  FilterChip(
                    label: Text("Rejected"),
                    selected: filterStatus == 'Rejected',
                    onSelected: (bool selected) {
                      setState(() {
                        filterStatus = selected ? 'Rejected' : 'All';
                      });
                    },
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
              // itemCount: userlembur.length,
              itemCount: filteredLembur.length,
              itemBuilder: (context, index) {
                // final isilembur = userlembur[index];
                final isilembur = filteredLembur[index];

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
                        //dipakai jika tanpa final cutiisi
                        // usercuti[index]['name']!,
                        isilembur['reason']!,
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
                                isilembur['date']!,
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
                                isilembur['name']!,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: Text(
                        isilembur['status']!,
                        style: TextStyle(
                            color: isilembur['status'] == 'Approved'
                                ? Colors.green
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
