import 'dart:ffi';

import 'package:absent_project/controller/TimeSheetsController/TimesheetsUser/MonthlyTimesheetModel.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetsUser/TimesheetsController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class detailMonthlyDialog extends StatefulWidget {
  final int selectedMonth;
  final int selectedYear;
  final String? clockOutId;

  const detailMonthlyDialog({required this.selectedMonth, required this.selectedYear, required this.clockOutId});

  @override
  State<detailMonthlyDialog> createState() => _detailMonthlyDialogState();
}

class _detailMonthlyDialogState extends State<detailMonthlyDialog> {
  late Future<MonthlyTimesheetModel>_timesheet;
  TimesheetsController timesheetsController = TimesheetsController();

  @override
  void initState() {
    super.initState();
    _timesheet = timesheetsController.detailMonthly(widget.selectedMonth, widget.selectedYear, widget.clockOutId);
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 500,
        width: 400,
        // padding: EdgeInsets.all(16.0),
        child: FutureBuilder<MonthlyTimesheetModel>(
          future: _timesheet, 
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            } else if (snapshot.hasError){
              return Center(child: Text("Error ${snapshot.error}"));
            } else if(snapshot.hasData){
              MonthlyTimesheetModel timesheet = snapshot.data!;
              String? formattedClockIn = timesheet.clockIn != null ? DateFormat('HH:mm:ss').format(timesheet.clockIn!) : null;
              String? formattedClockOut = timesheet.clockOut != null ? DateFormat('HH:mm:ss').format(timesheet.clockOut!) : null;

              List<String> questions = timesheet.questionText ?? [];
              List<String> answers = timesheet.answerText ?? [];
              List<String> platform = timesheet.platform ?? [];

              bool hasData = questions.isNotEmpty && answers.isNotEmpty && platform.isNotEmpty;
              int itemCount = hasData ? [questions.length, answers.length, platform.length].reduce((a, b) => a < b ? a : b) : 0;

              return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 400,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: 
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Icon(
                              Icons.alarm_on,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Detail Activity",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],)
                        ),
                      ),
                    ),

                    //isi
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Start",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                                ),
                              ),
                              SizedBox(width: 110,),
                              Text(
                                "End",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                formattedClockIn ?? "?",
                                style: TextStyle(
                                  fontSize: 12
                                ),
                              ),
                              SizedBox(width: 90,),
                              Text(
                                formattedClockOut ?? "?",
                                style: TextStyle(
                                  fontSize: 12
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                "Total : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                                ),
                              ),
                              SizedBox(width: 5,),
                              Text(
                                timesheet.elapsedTime ?? "?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          hasData
                          ? SizedBox(
                              height: 220.0, 
                              child: ListView.builder(
                                itemCount: itemCount,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${questions[index]} ${platform[index]}",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Answer: ${answers[index]}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Divider(), 
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Text(
                                "Data tidak tersedia.",
                                style: TextStyle(color: Colors.red, fontSize: 13),
                              ),
                            ),
                        ],
                      )
                    ),
                
                    Spacer(),
                    Column(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          width: 260,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, 
                            child: Text("Close",
                              style: TextStyle(
                                color: Colors.blue
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.blue, width: 2.0)

                              ),
                              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,)
                  ],
                );
            } else {
              return Center(child: Text("No data available"));
            }
          }
        )
      ),
    );
  }
}