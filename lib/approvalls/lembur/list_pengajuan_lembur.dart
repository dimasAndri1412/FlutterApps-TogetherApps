import 'package:absent_project/approvalls/lembur/pengajuan_lembur.dart';
import 'package:flutter/material.dart';

class ListPengajuanLembur extends StatefulWidget {
  const ListPengajuanLembur({super.key});

  @override
  State<ListPengajuanLembur> createState() => _ListPengajuanLemburState();
}

class _ListPengajuanLemburState extends State<ListPengajuanLembur> {
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
                            "Download",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text("Abie sakit")),
                          DataCell(Text("2024-12-12")),
                          DataCell(Text("")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("Febri pusing")),
                          DataCell(Text("2024-12-12")),
                          DataCell(Text("")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("Motor Iqbal meledak")),
                          DataCell(Text("2024-12-12")),
                          DataCell(Text("")),
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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PengajuanLembur()));
          },
          backgroundColor: Color.fromARGB(255, 98, 171, 232),
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
