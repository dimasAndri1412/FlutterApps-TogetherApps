import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/TimeEntryModel.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/TimeEntryController.dart';
import 'package:absent_project/timesheets/AdminPage/DailyTimeheets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeEntry extends StatefulWidget {
  final String ClockInId;
  const TimeEntry({super.key, required this.ClockInId});

  @override
  State<TimeEntry> createState() => _TimeEntryState();
}

class _TimeEntryState extends State<TimeEntry> {
  TimeEntryController timeEntryController = TimeEntryController();
  late Future<TimeEntryModel> timeEntry;
  DateTime? editableClockIn;
  String? formattedTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     timeEntry = timeEntryController.getClockIn(widget.ClockInId).then((data) {
      setState(() {
        editableClockIn = data.clockIn; 
        formattedTime = editableClockIn != null ? DateFormat('HH:mm:ss').format(editableClockIn!) : null;
      });
      return data;
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final initialTime = editableClockIn != null
      ? TimeOfDay.fromDateTime(editableClockIn!)
      : TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context, 
      initialTime: initialTime
    );

    if (picked != null) {
      setState(() {
        editableClockIn = DateTime(
          editableClockIn!.year,
          editableClockIn!.month,
          editableClockIn!.day,
          picked.hour,
          picked.minute,
        );

        formattedTime = DateFormat('HH:mm:ss').format(editableClockIn!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title:Center(
          title: Text(
            "Edit Clock In",
            style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        // ),
        // automaticallyImplyLeading: false,
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
      body: FutureBuilder(
        future: timeEntry, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError){
            return Center(child: Text("Error : ${snapshot.error}"),);
          } else if (!snapshot.hasData){
            return Center(child: Text("No Data Found"),);
          } else {
            final data = snapshot.data!;

            if (formattedTime == null && data.clockIn != null) {
              formattedTime = DateFormat('HH:mm:ss').format(data.clockIn!);
            }
            String? formattedDay = data.clockIn != null ? DateFormat('EEE, dd MMM yyyy').format(data.clockIn!) : null;

            return Container(
              margin: EdgeInsets.all(20),
              child:Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(data.pictClockIn)
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                          data.fullName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                        Text(
                          "via Android 10",
                          style: TextStyle(
                            fontSize: 12
                          ),
                        ),
                        Text(
                          "SM-G965F | star2lte",
                          style: TextStyle(
                            fontSize: 12
                          ),
                        ),
                      ],)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.login),
                      SizedBox(width: 20,),
                      Text(formattedTime ?? '-'),
                      IconButton(
                        icon: Icon(
                          Icons.edit, 
                          color: Colors.blue,
                          size: 20.0,
                        ),
                        onPressed: () => _selectTime(context), 
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 20,),
                      Text(data.location)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.label),
                      SizedBox(width: 20,),
                      Text(formattedDay ?? '-')
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.menu),
                      SizedBox(width: 20,),
                      Text("")
                    ],
                  ),
                  Spacer(),
                  // Container(
                  //   width: 320,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.red),
                  //     borderRadius: BorderRadius.circular(6)
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       "Delete Time Entry",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.red
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () async {
                      String formattedClockInTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(editableClockIn!);
                      await timeEntryController.editClockInTime(widget.ClockInId, formattedClockInTime);

                      Get.off(() => DailyTimesheets(selectedDay: editableClockIn!, clockInId: widget.ClockInId,));
                      
                      // Navigator.pop(context);
                    },
                    child: Container(
                      width: 320,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Center(
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            );
          }
        }
      )
    );
  }
}