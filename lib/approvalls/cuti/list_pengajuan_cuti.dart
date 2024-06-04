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
      'status': 'Rejected'
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
      'status': 'Rejected'
    },
    {
      'name': 'Rogape',
      'reason': 'cuti menikah',
      'date': '2024-12-07',
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
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
            child: Container(
              width: 500,
              // height: 100,
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
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Leave Statistics",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 2),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Leave Used"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Remaining Leave")
                            ]),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(":"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(":"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("2"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("10"),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: usercuti.length,
              itemBuilder: (context, index) {
                //panggil usercuti sebagai cutiisi
                final isicuti = usercuti[index];

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
                        'assets/images/job.png',
                        scale: 5,
                      ),
                      title: Text(
                        //dipakai jika tanpa final cutiisi
                        // usercuti[index]['name']!,
                        isicuti['reason']!,
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
                                isicuti['date']!,
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
                                isicuti['name']!,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: Text(
                        usercuti[index]['status']!,
                        style: TextStyle(
                            color: isicuti['status'] == 'Approved'
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
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PengajuanCuti()));
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
