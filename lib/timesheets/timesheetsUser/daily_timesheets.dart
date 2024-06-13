import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyTimesheets extends StatefulWidget {
  const DailyTimesheets(
      {Key? key,
      required this.trackedTime,
      // required this.selectedDay,
      required this.formattedDate})
      : super(key: key);

  // final DateTime selectedDay;
  final Map<String, String>? trackedTime;
  final String formattedDate;
  // final String _selectedDay;

  @override
  State<DailyTimesheets> createState() => _DailyTimesheetsState();
}

class _DailyTimesheetsState extends State<DailyTimesheets> {
  // DateTime _selectedDay = DateTime.now();

  Widget _buildTrackedTime(Map<String, String>? trackedTime) {
    final data = trackedTime ??
        {
          'firstIn': 'N/A',
          'lastOut': 'N/A',
          'breaks': 'N/A',
          'workedHours': 'N/A',
          // 'date':'${_selectedDay.day} - ${_selectedDay.month} - ${_selectedDay.year}'
        };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(data['date']!),
        // 'date':'${_selectedDay.day} - ${_selectedDay.month} - ${_selectedDay.year}'
        // SizedBox( height: 10, ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 30, bottom: 8),
          child: Text(
            widget.formattedDate,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 147, 195, 234),
                blurRadius: 5,
                offset: Offset(0, 4)),
          ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Center(
                  child: Text(
                    "Tracked Time",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // First Column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'First In',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(data['firstIn']!),
                        SizedBox(height: 16),
                        Text(
                          "Breaks",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(data['breaks']!),
                      ],
                    ),
                    // Second Column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Last Out",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(data['lastOut']!),
                        SizedBox(height: 16),
                        Text(
                          "Worked Hours",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(data['workedHours']!),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
          "Daily Timesheet",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text('First In: ${widget.trackedTime['firstIn']}'),
            // Text("data"),
            _buildTrackedTime(widget.trackedTime),
            // Add more widgets here if needed
          ],
        ),
      ),
    );
  }
}
