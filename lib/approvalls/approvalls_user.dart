import 'package:absent_project/approvalls/cuti/user/list_pengajuan_cuti.dart';
import 'package:absent_project/approvalls/lembur/user/list_pengajuan_lembur.dart';
import 'package:absent_project/approvalls/sakit/user/ListPengajuanSakit.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ApprovallsUser extends StatefulWidget {
  ApprovallsUser({super.key});

  @override
  State<ApprovallsUser> createState() => _ApprovallsUserState();
}

class _ApprovallsUserState extends State<ApprovallsUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          title: Center(
            child: Text("APPROVAL",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white)),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 147, 195, 234),
                            blurRadius: 15,
                            offset: Offset(5, 10),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.all(20),
                              child: Image.asset(
                                'assets/images/to-do-list.png',
                                width: 80,
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 0),
                            child: Text("Overtime Approval"),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListPengajuanLembur()),
                      );
                    },
                  ),
                  MaterialButton(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 147, 195, 234),
                            blurRadius: 15,
                            offset: Offset(5, 10),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.all(20),
                              child: Image.asset(
                                'assets/images/raise-hand.png',
                                width: 80,
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 0),
                            child: Text("Paid Leave Approval"),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => const ListPengajuanCuti());
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListPengajuanCuti()),
                      );*/
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 147, 195, 234),
                            blurRadius: 15,
                            offset: Offset(5, 10),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.all(20),
                              child: Image.asset(
                                'assets/images/hospital.png',
                                width: 80,
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 0),
                            child: Text("Sick Approval"),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListPengajuanSakit()),
                      );
                    },
                  ),
                  MaterialButton(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Container(
                      width: 160,
                      height: 160,
                    ),
                    onPressed: () {
                    
                    },
                  ),
                ],
              ),
            ],
          )
        ));
  }
}
