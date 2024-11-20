// import 'package:absent_project/approvalls/ProjectType.dart';
import 'package:absent_project/approvalls/cuti/ProjectType.dart' as cuti;
import 'package:absent_project/approvalls/cuti/msdo/ListUserCuti.dart';
import 'package:absent_project/approvalls/lembur/ProjectType.dart' as lembur;
import 'package:absent_project/approvalls/sakit/admin/ListUserSakit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'lembur/msdo/ListUserLembur.dart';

class Approvalls extends StatefulWidget {
  const Approvalls({super.key});

  @override
  State<Approvalls> createState() => _ApprovallsState();
}

class _ApprovallsState extends State<Approvalls> {
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
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      Get.to(() => ListUserLembur());
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ListUserCuti(), // Instantiate the class with prefix
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        // padding: EdgeInsets.only(top: 0),
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ListUserSakit() // Instantiate the class with prefix
                            ),
                          );
                        },
                      ),
                      MaterialButton(
                        onPressed: () {
                          
                        },
                        child: Container(
                          width: 160,
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ));
  }
}
