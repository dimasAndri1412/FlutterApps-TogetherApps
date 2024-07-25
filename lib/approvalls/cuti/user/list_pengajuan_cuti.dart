import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';

class ListPengajuanCuti extends StatefulWidget {
  const ListPengajuanCuti({
    super.key,
  });

  @override
  State<ListPengajuanCuti> createState() => _ListPengajuanCutiState();
}

class _ListPengajuanCutiState extends State<ListPengajuanCuti> {
  final MemberRequestPaidLeaveController memberInfo =
      MemberRequestPaidLeaveController();

/*  @override
  void initState() {
    super.initState();
    memberInfo.updateLeaveCount();
  }*/

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

  String filterStatus = 'All';
  List<Map<String, String>> get filteredCuti {
    if (filterStatus == "All") {
      return usercuti;
    }
    return usercuti.where((cuti) => cuti['status'] == filterStatus).toList();
  }

  //Function Filter Alert Dialog
  void _showFilterOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Select Filter',
            style: TextStyle(fontWeight: FontWeight.w500),
          )),
          content: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Divider(),
                // ListTile(
                //   leading: Icon(Icons.new_releases),
                //   title: Text('New'),
                //   onTap: () {
                //     setState(() {
                //       filterStatus = 'New';
                //     });
                //     Navigator.pop(context);
                //   },
                // ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.select_all),
                  title: Text('All'),
                  onTap: () {
                    setState(() {
                      filterStatus = 'All';
                    });
                    Navigator.pop(context);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.done),
                  title: Text('Approved'),
                  onTap: () {
                    setState(() {
                      filterStatus = 'Approved';
                    });
                    Navigator.pop(context);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.dnd_forwardslash),
                  title: Text('Rejected'),
                  onTap: () {
                    setState(() {
                      filterStatus = 'Rejected';
                    });
                    Navigator.pop(context);
                  },
                ),
                Divider(),
              ],
            ),
          ),
        );
      },
    );
  }

  //function detail cuti
  void _showDetail(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              // height: 200,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Detail Cuti",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    // thickness: 1
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Status ", style: TextStyle(fontSize: 15)),
                            Text("Description ", style: TextStyle(fontSize: 15))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(": "),
                            Text(": "),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("isi"),
                              Text("isi"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${memberInfo.leaveUsed}"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("${memberInfo.remainingLeave}"),
                                  ],
                                );
                              }
                            })
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
          GestureDetector(
            onTap: () => _showFilterOptions(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(left: 15, top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filter: $filterStatus',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          // FutureBuilder(
          //     future: MemberRequestPaidLeaveController().getList(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const CircularProgressIndicator();
          //       } else if (snapshot.hasError) {
          //         return const Text("");
          //       } else {
          // return
          Expanded(
              // child: RefreshIndicator(
              // onRefresh: () => memberInfo.refresh(),
              child: ListView.builder(
            /*itemCount: snapshot.data?.length,*/
            itemCount: filteredCuti.length,
            itemBuilder: (context, index) {
              //panggil usercuti sebagai cutiisi
              /*var getUser = snapshot.data![index];*/
              final isicuti = filteredCuti[index];
              return GestureDetector(
                onTap: () => _showDetail(context),
                child: Padding(
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
                        /*getUser.reasonLeave,*/
                        isicuti['reason']!,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
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
                                /*getUser.startDateLeave,*/
                                isicuti['date']!,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.supervised_user_circle_outlined),
                              const SizedBox(width: 5),
                              Text(
                                /*getUser.name,*/
                                isicuti['name']!,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: Text(
                        /*getUser.status,*/
                        usercuti[index]['status']!,
                        style: TextStyle(
                            /*color: getUser.status== 'new'*/
                            color: isicuti['status'] == 'Approved'
                                ? Colors.green
                                : isicuti['status'] == 'New'
                                    ? Colors.blue
                                    : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
              // )
              )
          // ;
          // }
          // }
          // )
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
