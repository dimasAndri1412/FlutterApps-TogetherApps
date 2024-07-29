// import 'dart:ffi';

import 'package:absent_project/timesheets/AdminPage/TimeEntry.dart';
import 'package:flutter/material.dart';

class DailyTimesheets extends StatefulWidget {
  const DailyTimesheets({super.key});

  @override
  State<DailyTimesheets> createState() => _DailyTimesheetsState();
}

class _DailyTimesheetsState extends State<DailyTimesheets> {
  // bool _isExpanded = false;
  bool _customTileExpanded = false;

  // void _toggleExpand() {
  //   setState(() {
  //     _isExpanded = !_isExpanded;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text(
            "Daily Timesheets",
            style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 147, 195, 234),
                    Color.fromARGB(255, 98, 171, 232),
                    Color.fromARGB(255, 123, 185, 235),
                  ]
                ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 10,),
                        Text('Only scheduled hours are included')
                      ],
                    ),
                  )
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Tue, 25 Jun',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                // height: 260,
                decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://w0.peakpx.com/wallpaper/280/151/HD-wallpaper-bts-jungkook-kookie.jpg')
                          ),
                          SizedBox(width: 10,),
                          Center(
                            child: Text(
                              "Jeon Jungkook",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      // indent: 2,
                      // endIndent: 2,
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Tracked Time',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      child: Row(
                        children: [
                          Text('First in',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                          SizedBox(width: 150,),
                          Text('Last Out',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.normal
                            ),
                          )
                        ],
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('7:28',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 160,),
                          Text('-',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      )
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      child: Row(
                        children: [
                          Text('Breaks',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                          SizedBox(width: 150,),
                          Text('Worked Hours',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.normal
                            ),
                          )
                        ],
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('0h 00m',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 140,),
                          Text('7h 41m',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      )
                    ),
                    SizedBox(height: 10,),
                    ExpansionTile(
                      title: const Text('Time Entries',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      // subtitle: const Text('Custom expansion arrow icon'),
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                          Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => TimeEntry()));
                        },
                        child: ListTile(
                          title: Text('06:58'),
                          subtitle: Text('Shift 1'),
                          leading: CircleAvatar(),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.phone_android,
                                size: 17,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.location_on_outlined,
                                size: 18,
                                color: Colors.grey  
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 18,
                                color: Colors.grey,  
                              )
                            ],
                          ),
                        ),
                        )
                      ],
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          _customTileExpanded = expanded;
                        });
                      },
                    ),
                  ],
                )
              ),
              SizedBox(height: 20,),
              Container(
                // height: 260,
                decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Payroll Hours',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.only(left: 20, right: 80, bottom: 5),
                      child: Row(
                        children: [
                          Text('Regular hours',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                           SizedBox(width: 100,),
                          Text('Overtime hours  ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.normal
                            ),
                          )
                        ],
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('7:28',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 150,),
                          Text('-',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      )
                    ),
                    SizedBox(height: 10,),
                    ExpansionTile(
                      title: const Text('Breakdown',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      // subtitle: const Text('Custom expansion arrow icon'),
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Text("Tracked hours"),
                                Spacer(),
                                Text("7h 56m",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Text("Worked hours"),
                                Spacer(),
                                Text("7h 56m",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          )
                        ),
                        SizedBox(height: 20,),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Text("Payroll hours"),
                                Spacer(),
                                Text("7h 56m",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, bottom: 30),
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Text("Regular hours"),
                                Spacer(),
                                Text("7h 56m",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          )
                        )
                      ],
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          _customTileExpanded = expanded;
                        });
                      },
                    ),
                  ],
                )
              ),
              // ListTile(
              //   title: Center(
              //     child: IconButton(
              //       icon: Icon(
              //         _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              //         size: 30,
              //       ),
              //       onPressed: _toggleExpand,
              //     ),
              //   ),
              // ),
              // Visibility(
              //   visible: _isExpanded,
              //   child: Container(
              //       color: Colors.white, // Set the background color here
              //       child: Column(
              //         children: [
              //           Container(
              //             padding: EdgeInsets.all(10),
              //             child: Text(
              //               'Detail Information',
              //               style: TextStyle(fontSize: 14),
              //             ),
              //           ),
              //           Container(
              //             padding: EdgeInsets.all(10),
              //             child: Text(
              //               'More details can be shown here when expanded.',
              //               style: TextStyle(fontSize: 14),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              // )
            ],
          )
        )
      )
    );
  }
}