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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List Leave Request",
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
        child: Container(
          margin: EdgeInsets.only(right: 5, top: 10),
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
                            "Download",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text("Jalan - jalan")),
                          DataCell(Text("2024-12-12")),
                          DataCell(ElevatedButton(
                            child: Row(
                              children: [
                                Icon(Icons.download),
                                Text("Download PDF")
                              ],
                            ),
                            onPressed: () {
                              downloadFile();
                            },
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("Pergi ke RS")),
                          DataCell(Text("2024-12-12")),
                          DataCell(ElevatedButton(
                            child: Row(
                              children: [
                                Icon(Icons.download),
                                Text("Download PDF")
                              ],
                            ),
                            onPressed: () {
                              downloadFile();
                            },
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("urus SIM dan STNK")),
                          DataCell(Text("2024-12-12")),
                          DataCell(ElevatedButton(
                            child: Row(
                              children: [
                                Icon(Icons.download),
                                Text("Download PDF")
                              ],
                            ),
                            onPressed: () {
                              downloadFile();
                            },
                          )),
                        ]),
                      ],
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
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PengajuanCuti()));
          },
          backgroundColor: Color.fromARGB(255, 98, 171, 232),
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void downloadFile() async {
    var time = DateTime.now().millisecondsSinceEpoch;
    var path = "/storage/emulator/0/Download/images-$time.jpg";
    var file = File(path);
    var res = await get(Uri.parse("https://source.unsplash.com/random"));
    file.writeAsBytes(res.bodyBytes);
  }
}
