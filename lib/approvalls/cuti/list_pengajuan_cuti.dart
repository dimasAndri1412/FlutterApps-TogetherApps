import 'dart:io';

import 'package:absent_project/approvalls/cuti/pengajuan_cuti.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ListPengajuanCuti extends StatefulWidget {
  const ListPengajuanCuti({super.key});

  @override
  State<ListPengajuanCuti> createState() => _ListPengajuanCutiState();
}

class _ListPengajuanCutiState extends State<ListPengajuanCuti> {
  final List<Map<String, String>> usercuti = [
    {
      'name': 'Rogape',
      'reason': 'Jalan - jalan ke Bali',
      'date': '2024-12-01',
      'status': 'Approved'
    },
    {
      'name': 'Rogape',
      'reason': 'Pergi ke RSJ',
      'date': '2024-12-02',
      'status': 'Approved'
    },
    {
      'name': 'Rogape',
      'reason': 'Jinakin Bom',
      'date': '2024-12-03',
      'status': 'Approved'
    },
    {
      'name': 'Rogape',
      'reason': 'jajan ke Paris',
      'date': '2024-12-04',
      'status': 'Approved'
    },
    {
      'name': 'Rogape',
      'reason': 'beli sendal di US',
      'date': '2024-12-05',
      'status': 'Approved'
    },
    {
      'name': 'Rogape',
      'reason': 'cari pokemon',
      'date': '2024-12-06',
      'status': 'Approved'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List Paid Leave Request",
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
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Container(
                width: 350,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 147, 195, 234),
                          blurRadius: 5,
                          offset: Offset(0, 0))
                    ]),
                /////////
                child: Padding(
                  padding: const EdgeInsets.only(left: 100, top: 30),
                  child: Table(
                    columnWidths: {
                      0: FixedColumnWidth(120),
                      1: FixedColumnWidth(20),
                      // 2: FixedColumnWidth(50),
                    },
                    children: [
                      TableRow(children: [
                        Text(
                          "Leave Used ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ":",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("2"),
                      ]),
                      TableRow(children: [
                        Text(
                          "Remaining Leave ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ":",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("10"),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
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
                                "Reason of Leave",
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
                          rows: usercuti.map((usercuti) {
                            return DataRow(cells: [
                              DataCell(Text(usercuti['name']!)),
                              DataCell(Text(usercuti['reason']!)),
                              DataCell(Text(usercuti['date']!)),
                              DataCell(Text(
                                usercuti['status']!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ]);
                          }).toList(),
                          // rows: [
                          //   DataRow(cells: [
                          //     DataCell(Text("Rogape")),
                          //     DataCell(Text("Jalan - jalan")),
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
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PengajuanCuti()));
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
