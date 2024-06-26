import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';

class ListPengajuanCuti extends StatefulWidget {
   const ListPengajuanCuti({super.key,});

  @override
  State<ListPengajuanCuti> createState() => _ListPengajuanCutiState();
}

class _ListPengajuanCutiState extends State<ListPengajuanCuti> {
  final MemberRequestPaidLeaveController memberInfo = MemberRequestPaidLeaveController();

/*  @override
  void initState() {
    super.initState();
    memberInfo.updateLeaveCount();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "List Paid Leave Request",
          style: TextStyle(fontSize: 15),
        ),
        flexibleSpace: Container(
          decoration:  BoxDecoration(
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
                  boxShadow:  [
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
                        FutureBuilder(
                            future: memberInfo.getLeave(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else {
                                return Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("${memberInfo.leaveUsed}"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("${memberInfo.remainingLeave}"),
                                    ],
                                  );
                            }
                            }
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
         FutureBuilder(
             future: MemberRequestPaidLeaveController().getList(),
             builder: (context, snapshot){
           if(snapshot.connectionState == ConnectionState.waiting){
             return const CircularProgressIndicator(
             );
           }else if (snapshot.hasError) {
             return const Text("");
           }else{
             return Expanded(
                 child: RefreshIndicator(
                   onRefresh: () => memberInfo.refresh(),
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
               )
                 )
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
