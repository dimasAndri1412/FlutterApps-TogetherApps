import 'package:absent_project/approvalls/cuti/pengajuan_cuti.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeave.dart';

class ListPengajuanCuti extends StatefulWidget {
  const ListPengajuanCuti({super.key});

  @override
  State<ListPengajuanCuti> createState() => _ListPengajuanCutiState();
}

class _ListPengajuanCutiState extends State<ListPengajuanCuti> {
  final MemberRequestPaidLeaveController memberInfo = MemberRequestPaidLeaveController();

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
        title: const Text(
          "List Paid Leave Request",
          style: TextStyle(fontSize: 15),
        ),
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
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 147, 195, 234),
                        blurRadius: 5,
                        offset: Offset(0, 0))
                  ]),
              /////////
              child: const Column(
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
                    padding: EdgeInsets.all(8.0),
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
          const SizedBox(
            height: 20,
          ),
         FutureBuilder(future: MemberRequestPaidLeaveController().getList(),
             builder: (context, snapshot){
           if(snapshot.data == null){
             return const Text("");
           }else{
             return Expanded(
               child: ListView.builder(
                 itemCount: snapshot.data?.length,
                 itemBuilder: (context, index) {
                   //panggil usercuti sebagai cutiisi
                   var getUser = snapshot.data![index];
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
                           getUser.reasonLeave,
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
                                   getUser.startDateLeave,
                                   style:
                                   const TextStyle(
                                       color: Colors.grey, fontSize: 10),
                                 ),
                               ],
                             ),
                             Row(
                               children: [
                                 const Icon(
                                     Icons.supervised_user_circle_outlined),
                                 const SizedBox(width: 5),
                                 Text(
                                   getUser.name,
                                   style:
                                   const TextStyle(
                                       color: Colors.grey, fontSize: 10),
                                 ),
                               ],
                             )
                           ],
                         ),
                         trailing: Text(
                           getUser.status,
                           style: TextStyle(
                               color: getUser.status == 'new'
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
             );
           }
             }
         )

        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
          onPressed: () {
            memberInfo.getInfo();
            /*Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const PengajuanCuti()));*/
          },
          backgroundColor: const Color.fromARGB(255, 98, 171, 232),
          elevation: 5,
          child: const Icon(Icons.edit),
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
