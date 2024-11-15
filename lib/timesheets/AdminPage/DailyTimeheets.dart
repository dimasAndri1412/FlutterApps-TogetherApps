// import 'dart:ffi';

import 'package:absent_project/approvalls/Approvalls.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/ListTimesheetsController.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/ListTimesheetsModel.dart';
import 'package:absent_project/home/ApplicationBar.dart';
import 'package:absent_project/timesheets/AdminPage/MonthlyReport.dart';
import 'package:absent_project/timesheets/AdminPage/MonthlyTimesheets.dart';
import 'package:absent_project/timesheets/AdminPage/TimeEntryClockIn.dart';
import 'package:absent_project/timesheets/AdminPage/TimeEntryClockOut.dart';
import 'package:absent_project/timesheets/AdminPage/Timesheets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

class DailyTimesheets extends StatefulWidget {
  final DateTime selectedDay;
  final String clockInId;
  const DailyTimesheets({super.key,
    required this.selectedDay,
    required this.clockInId
  });

  @override
  State<DailyTimesheets> createState() => _DailyTimesheetsState();
}

class _DailyTimesheetsState extends State<DailyTimesheets> {
  final listTimesheetsController = ListTimesheetsController();
  late Future<ListTimesheetsModel> _future;
  // bool _isExpanded = false;
  bool _customTileExpanded = false;

  // void _toggleExpand() {
  //   setState(() {
  //     _isExpanded = !_isExpanded;
  //   });
  // }
  

  @override
  void initState() {
    super.initState();
   
    _loadData();
  }

  void _loadData() {
  setState(() {
    _future = listTimesheetsController.getDaily(widget.selectedDay, widget.clockInId);
  });
}

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('EE, d MMM yyyy');
    final String formattedDate = formatter.format(widget.selectedDay);

    return Scaffold(
      appBar: AppBar(
        title:
          Text(
            "Daily Timesheets",
            style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.white,),
        //   onPressed: () {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => ApplicationBar(), 
        //       ),
        //     );
        //   },
        // ),
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
          child: FutureBuilder<ListTimesheetsModel>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              } else if (snapshot.hasError) {
                return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
              }else if (snapshot.hasData && snapshot.data != null){
                ListTimesheetsModel daily = snapshot.data!;
                String? formattedClockIn = daily.clockIn != null ? DateFormat('HH:mm').format(daily.clockIn!) : null;
                String? formattedClockOut = daily.clockOut != null ? DateFormat('HH:mm').format(daily.clockOut!) : null;
                return Column(
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
                              offset: Offset(0, 3), 
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
                        formattedDate,
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
                      child : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(daily.imagePath)
                                ),
                                SizedBox(width: 10,),
                                Center(
                                  child: Text(
                                    daily.fullName ?? "n/a",
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
                                Text(formattedClockIn ?? " - ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(width: 160,),
                                Text(formattedClockOut ?? " - ",
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
                                Text('',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal
                                  ),
                                ),
                                SizedBox(width: 190,),
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
                                Text('',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(width: 200,),
                                Text(daily.elapsedTime ?? "-",
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
                                  .push(MaterialPageRoute(builder: (context) => TimeEntry(ClockInId: daily.clockInID)));
                              },
                                child: ListTile(
                                  title: Text(formattedClockIn ?? "-"),
                                  subtitle: Text(daily.shift ?? "-"),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(daily.pictClockIn)
                                  ),
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
                              ),
                              if(daily.clockOut != null)
                              GestureDetector(
                                onTap: (){
                                Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => TimeEntryClockOut(clockOutId: daily.clockOutID, clockInId: daily.clockInID,)));
                              },
                                child: ListTile(
                                  title: Text(formattedClockOut ?? "-"),
                                  subtitle: Text(daily.shift ?? "-"),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(daily.pictClockOut)
                                  ),
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
                              print("halo");
                              setState(() {
                                _customTileExpanded = expanded;
                              });
                            },
                          ),
                        ],
                      )
                    ),
                    SizedBox(height: 20,),
                    // Container(
                    //   // height: 260,
                    //   decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey.withOpacity(0.5),
                    //       spreadRadius: 0,
                    //       blurRadius: 2,
                    //       offset: Offset(0, 3), // changes position of shadow
                    //     ),
                    //   ],
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         margin: EdgeInsets.all(10),
                    //         child: Text(
                    //           'Payroll Hours',
                    //           style: TextStyle(
                    //             fontSize: 13,
                    //             fontWeight: FontWeight.bold
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         margin: EdgeInsets.only(left: 20, right: 80, bottom: 5),
                    //         child: Row(
                    //           children: [
                    //             Text('Regular hours',
                    //               style: TextStyle(
                    //                 color: Colors.grey,
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.normal
                    //               ),
                    //             ),
                    //             SizedBox(width: 100,),
                    //             Text('Overtime hours  ',
                    //               style: TextStyle(
                    //                 color: Colors.grey,
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.normal
                    //               ),
                    //             )
                    //           ],
                    //         )
                    //       ),
                    //       Container(
                    //         margin: EdgeInsets.only(left: 20, right: 20, top: 2),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Text(daily.elapsedTime ?? "-",
                    //               style: TextStyle(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.bold
                    //               ),
                    //             ),
                    //             SizedBox(width: 150,),
                    //             Text('-',
                    //               style: TextStyle(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.bold
                    //               ),
                    //             )
                    //           ],
                    //         )
                    //       ),
                    //       SizedBox(height: 10,),
                    //       ExpansionTile(
                    //         title: const Text('Breakdown',
                    //           style: TextStyle(
                    //             fontSize: 13,
                    //             fontWeight: FontWeight.bold
                    //           ),
                    //         ),
                    //         // subtitle: const Text('Custom expansion arrow icon'),
                    //         children: <Widget>[
                    //           Container(
                    //             margin: EdgeInsets.only(left: 10, right: 10),
                    //             height: 50,
                    //             decoration: BoxDecoration(
                    //               border: Border.all(),
                    //             ),
                    //             child: Padding(
                    //               padding: EdgeInsets.all(10),
                    //               child: Row(
                    //                 children: [
                    //                   Text("Tracked hours"),
                    //                   Spacer(),
                    //                   Text("7h 56m",
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.bold
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             )
                    //           ),
                    //           Container(
                    //             margin: EdgeInsets.only(left: 10, right: 10),
                    //             height: 50,
                    //             decoration: BoxDecoration(
                    //               border: Border.all(),
                    //             ),
                    //             child: Padding(
                    //               padding: EdgeInsets.all(10),
                    //               child: Row(
                    //                 children: [
                    //                   Text("Worked hours"),
                    //                   Spacer(),
                    //                   Text("7h 56m",
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.bold
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             )
                    //           ),
                    //           SizedBox(height: 20,),
                    //           Container(
                    //             margin: EdgeInsets.only(left: 10, right: 10),
                    //             height: 50,
                    //             decoration: BoxDecoration(
                    //               border: Border.all(),
                    //             ),
                    //             child: Padding(
                    //               padding: EdgeInsets.all(10),
                    //               child: Row(
                    //                 children: [
                    //                   Text("Payroll hours"),
                    //                   Spacer(),
                    //                   Text("7h 56m",
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.bold
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             )
                    //           ),
                    //           Container(
                    //             margin: EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    //             height: 50,
                    //             decoration: BoxDecoration(
                    //               border: Border.all(),
                    //             ),
                    //             child: Padding(
                    //               padding: EdgeInsets.all(10),
                    //               child: Row(
                    //                 children: [
                    //                   Text("Regular hours"),
                    //                   Spacer(),
                    //                   Text("7h 56m",
                    //                     style: TextStyle(
                    //                       fontWeight: FontWeight.bold
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             )
                    //           )
                    //         ],
                    //         onExpansionChanged: (bool expanded) {
                    //           setState(() {
                    //             _customTileExpanded = expanded;
                    //           });
                    //         },
                    //       ),
                    //     ],
                    //   )
                    // ),
                    SizedBox(height: 10,),
                    TextButton(
                      child: Center(
                        child: Container(
                          child: Text(
                            "View Monthly Timesheet",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        int selectedMonth = widget.selectedDay.month;
                        int selectedYear = widget.selectedDay.year;
                        String userId = daily.userId;
                        final pdf = await MonthlyTimesheets().generatePdf(
                          userId,
                          selectedMonth,
                          selectedYear
                        );
                        await Printing.layoutPdf(onLayout: (format) => pdf);
                      },
                    ),
                     TextButton(
                      child: Center(
                        child: Container(
                          child: Text(
                            "View Monthly Report",
                            style: TextStyle(color: Colors.orange, fontSize: 16),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        int selectedMonth = widget.selectedDay.month;
                        int selectedYear = widget.selectedDay.year;
                        String userId = daily.userId;
                        final pdf = await MonthlyReport().GeneratePDF(
                          userId,
                          selectedMonth,
                          selectedYear
                        );
                        await Printing.layoutPdf(onLayout: (format) => pdf);
                      },
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text("Gagal memuat data."),
                );
              }
            },
          )
        )
      )
    );
  }
}