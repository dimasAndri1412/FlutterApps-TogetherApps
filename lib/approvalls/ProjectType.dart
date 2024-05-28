import 'package:flutter/material.dart';
import 'package:absent_project/approvalls/cuti/ListUserCuti.dart';
import 'package:absent_project/approvalls/lembur/ListUserLembur.dart';

class ProjectType extends StatefulWidget {
  final String type; // Add this parameter to distinguish between leave and overtime
  const ProjectType({super.key, required this.type});


  @override
  State<ProjectType> createState() => _ProjectTypeState();
}

class _ProjectTypeState extends State<ProjectType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          // title: Center(
          //   child: Text("A P P R O V A L"),
          // ),
        ),
        body: Container(
          child: Row(
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
                            'assets/images/analysis.png',
                            width: 80,
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Text("MSDO Project"),
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.type == 'paid-leave'
                        ? const ListUserCuti()
                        : const ListUserLembur(),
                    ),
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
                            'assets/images/coding.png',
                            width: 80,
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Text("Development Project"),
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.type == 'paid-leave'
                        ? const ListUserCuti()
                        : const ListUserLembur(),
                    ),
                  );
                },
              ),
            ],
          ),
        ));;
  }
}