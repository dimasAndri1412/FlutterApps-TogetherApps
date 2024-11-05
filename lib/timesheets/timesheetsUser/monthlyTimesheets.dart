import 'package:absent_project/controller/TimeSheetsController/TimesheetsUser/MonthlyTimesheetModel.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetsUser/TimesheetsController.dart';
import 'package:absent_project/timesheets/timesheetsUser/detailMonthlyDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class monthlyTimesheets extends StatefulWidget {
  final int selectedMonth;
  final int selectedYear;

  const monthlyTimesheets({required this.selectedMonth, required this.selectedYear});

  @override
  State<monthlyTimesheets> createState() => _monthlyTimesheetsState();
}

class _monthlyTimesheetsState extends State<monthlyTimesheets> {
  late Future<List<MonthlyTimesheetModel>> _timesheet;
  TimesheetsController timesheetsController = TimesheetsController();

  @override
  void initState() {
    super.initState();
    _timesheet = timesheetsController.getMonthly(widget.selectedMonth, widget.selectedYear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          "Monthly Timesheet",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(width: 0.5, color: Colors.grey),
        ),
        child: FutureBuilder<List<MonthlyTimesheetModel>>(
        future: _timesheet,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError){
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data == null){
              return Center(child: Text("No Data available"));
            }

            final timesheetList = snapshot.data!;
            return 
            ListView.builder(
              itemCount: timesheetList.length,
              itemBuilder: (context, index){
                final timesheet = timesheetList[index];
                String? formattedClockIn = timesheet.clockIn != null ? DateFormat('dd MMM yyyy').format(timesheet.clockIn!) : null;
                return Container(
                   decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(width: 0.5, color: Colors.grey),
                    ),
                    child: ListTile(
                      title: Text(
                        formattedClockIn ?? "n/a",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(
                                Icons.work,
                                size: 18,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                timesheet.shift ?? "n/a",
                                style: TextStyle(
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                size: 18,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 12, height: 2),
                              ),
                                SizedBox(
                                width: 3,
                              ),
                              Flexible(
                                child: Text(
                                  timesheet.location ?? "n/a",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.assessment_outlined, color: Colors.black),
                        onPressed: () {
                          print('Button clicked');
                          showDialog(
                            context: context, 
                            builder: (BuildContext context){
                              return detailMonthlyDialog(
                                selectedMonth: widget.selectedMonth,
                                selectedYear: widget.selectedYear,
                                clockOutId: timesheet.clockOutId,
                              );
                            }
                          );
                        },
                      ),
                    )
                );   
              }
            );
          }
        )
      )
    );
  }
}