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
        children: [
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userlembur.length,
              itemBuilder: (context, index) {
                //panggil usercuti sebagai cutiisi
                final isilembur = userlembur[index];

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
                        userlembur[index]['status']!,
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
