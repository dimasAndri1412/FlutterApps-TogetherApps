import 'package:absent_project/timesheets/daily_timesheets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TimesheetsUser extends StatefulWidget {
  const TimesheetsUser({super.key});

  @override
  State<TimesheetsUser> createState() => _TimesheetsUserState();
}

class _TimesheetsUserState extends State<TimesheetsUser> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime today = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Map<DateTime, Map<String, String>> trackedTimes = {
    DateTime.utc(2024, 6, 03): {
      'firstIn': '08:05',
      'lastOut': '17:05',
      'breaks': '0h 0m',
      'workedHours': '9h',
    },
    DateTime.utc(2024, 6, 04): {
      'firstIn': '09:05',
      'lastOut': '18:15',
      'breaks': '0h 0m',
      'workedHours': '9h10m',
    },
    DateTime.utc(2024, 6, 05): {
      'firstIn': '09:55',
      'lastOut': '20:55',
      'breaks': '0h 0m',
      'workedHours': '11h',
    },
    DateTime.utc(2024, 6, 06): {
      'firstIn': '07:00',
      'lastOut': '19:00',
      'breaks': '0h 0m',
      'workedHours': '12h',
    },
  };

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _onFormatChanged(format) {
    if (_calendarFormat != format) {
      setState(() => _calendarFormat = format);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //KALENDER
            Container(
              // height: 350,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 147, 195, 234),
                    blurRadius: 5,
                    offset: Offset(0, 4))
              ]),
              child: calendar(),
            ),
            SizedBox(
              height: 25,
            ),

            //TRACKED TIME
            _buildTrackedTime(),

            SizedBox(height: 25),

            //LINK DAILY
            TextButton(
              child: Center(
                child: Container(
                  child: Text(
                    "View Daily Timesheet",
                    style: TextStyle(color: Colors.orange, fontSize: 16),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DailyTimesheets()));
              },
            ),
          ],
        ),
      ),
    );
  }

  //WIDGET CALENDER
  Widget calendar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          // Text("Selected Day = " + today.toString().split(" ")[0]),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              child: TableCalendar(
                locale: "en_US",
                rowHeight: 43,
                availableGestures: AvailableGestures.all,
                firstDay: DateTime.utc(2019, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                // selectedDayPredicate: (day) => isSameDay(today, day),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                // onDaySelected: _onDaySelected,
                // onFormatChanged: _onFormatChanged,
                calendarFormat: _calendarFormat,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackedTime() {
    final trackedTime = trackedTimes[_selectedDay] ??
        {
          'firstIn': 'N/A',
          'lastOut': 'N/A',
          'breaks': 'N/A',
          'workedHours': 'N/A',
        };

    return Container(
      // height: 90,
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
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //KOLOM KE - 1
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'First In',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(trackedTime['firstIn']!),
                    // style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Breaks",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(trackedTime['breaks']!),
                    // style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                //KOLOM KE - 2
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last Out",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(trackedTime['lastOut']!),
                    // style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Worked Hours",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(trackedTime['workedHours']!),
                    // style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
