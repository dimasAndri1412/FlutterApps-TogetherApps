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
      'status': 'Approved'
    },
    {
      'name': 'Rogape',
      'reason': 'Kosong',
      'date': '2024-12-04',
      'status': 'Approved'
    },
  ];

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
      body: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: Container(
          margin: EdgeInsets.only(right: 5, top: 10, bottom: 85),
          child: Center(
            child: Column(
              children: [
                SingleChildScrollView(
                  // scrollDirection: Axis.horizontal,
                  child: FittedBox(
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Reason of Overtime",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Date",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Status Approval",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: userlembur.map((userlembur) {
                        return DataRow(cells: [
                          DataCell(Text(userlembur['name']!)),
                          DataCell(Text(userlembur['reason']!)),
                          DataCell(Text(userlembur['date']!)),
                          DataCell(Text(
                            userlembur['status']!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ]);
                      }).toList(),
                      // rows: [
                      //   DataRow(cells: [
                      //     DataCell(Text("Rogape")),
                      //     DataCell(Text("kena Covid - 24")),
                      //     DataCell(Text("2024-12-12")),
                      //     DataCell(Center(
                      //         child: Text(
                      //       "Approved",
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ))),
                      //   ]),
                      // ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PengajuanLembur()));
          },
          backgroundColor: Color.fromARGB(255, 98, 171, 232),
          child: Icon(Icons.add),
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
