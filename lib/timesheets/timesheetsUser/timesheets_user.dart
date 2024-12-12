import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetsUser/TimesheetsController.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetsUser/TimesheetsModel.dart';
import 'package:absent_project/timesheets/timesheetsUser/daily_timesheets.dart';
import 'package:absent_project/timesheets/timesheetsUser/monthlyTimesheets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TimesheetsUser extends StatefulWidget {
  const TimesheetsUser({super.key});

  @override
  State<TimesheetsUser> createState() => _TimesheetsUserState();
}

class _TimesheetsUserState extends State<TimesheetsUser> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
   String _calendarFormatText = 'Month';
  DateTime today = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();


  Map<DateTime, Map<String, String>> trackedTimes = {
    DateTime.utc(2024, 6, 12): {
      'firstIn': '08:05',
      'lastOut': '17:05',
      'breaks': '0h 0m',
      'workedHours': '9h',
      'date': ''
    },
    DateTime.utc(2024, 6, 13): {
      'firstIn': '09:05',
      'lastOut': '18:15',
      'breaks': '0h 0m',
      'workedHours': '9h10m',
    },
    DateTime.utc(2024, 6, 14): {
      'firstIn': '09:55',
      'lastOut': '20:55',
      'breaks': '0h 0m',
      'workedHours': '11h',
    },
    DateTime.utc(2024, 6, 15): {
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

  // void _onFormatChanged(format) {
  //   if (_calendarFormat != format) {
  //     setState(() => _calendarFormat = format);
  //   }
  // }

  void _onFormatChanged(CalendarFormat format) {
  if (_calendarFormat != format) {
    setState(() {
      _calendarFormat = format;
      // Perbarui _calendarFormatText sesuai dengan format yang dipilih
      if (_calendarFormat == CalendarFormat.week) {
        _calendarFormatText = 'Week';
      } else if (_calendarFormat == CalendarFormat.twoWeeks) {
        _calendarFormatText = '2 Weeks';
      } else if (_calendarFormat == CalendarFormat.month) {
        _calendarFormatText = 'Month';
      }
    });
  }
}

  @override
  Widget build(BuildContext context) {
    //untuk menampilkan detail tanggal
    final DateFormat formatter = DateFormat('EE, d MMM yyyy');
    final String formattedDate = formatter.format(_selectedDay);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              height: 30,
            ),

            // SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                formattedDate,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            //TRACKED TIME
            _buildTrackedTime(formattedDate),

            TextButton(
              child: Center(
                child: Container(
                  child: Text(
                    "View Monthly Timesheet",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ),
              onPressed: () {
                int selectedMonth = _selectedDay.month;
                int selectedYear = _selectedDay.year;
                print('Selected Month: $selectedMonth');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => monthlyTimesheets(selectedMonth: selectedMonth, selectedYear: selectedYear,)
                  )
                );
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
                    print("selected $_selectedDay");
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: _onFormatChanged,
                // onDaySelected: _onDaySelected,
                // onFormatChanged: _onFormatChanged,
                calendarFormat: _calendarFormat,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false, 
                  titleCentered: true,
                ),
                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (context, date) {
                    final monthName = DateFormat('MMMM').format(date);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          monthName, 
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_calendarFormat == CalendarFormat.week) {
                              _onFormatChanged(CalendarFormat.month);
                            } else if (_calendarFormat == CalendarFormat.month) {
                              _onFormatChanged(CalendarFormat.twoWeeks);
                            } else {
                              _onFormatChanged(CalendarFormat.week);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6), 
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black, 
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8), 
                            ),
                            child: Text(
                              _calendarFormatText, 
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  

  Widget _buildTrackedTime(String formattedDate) {
    return FutureBuilder<TimesheetsModel>(
      future: TimesheetsController().getLatestAttendance(_selectedDay),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData && snapshot.data != null){
          TimesheetsModel trackedTime = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("${_selectedDay.day} - ${_selectedDay.month} - ${_selectedDay.year}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

              // Padding(
              //   padding: const EdgeInsets.only(left: 15),
              //   child: Text(formatedDate,style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              // ),

              // Text(trackedTime['date']!),
              SizedBox(
                height: 8,
              ),
              Container(
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
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 15, right: 15),
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
                               Text(trackedTime.timeFormat(trackedTime.clockIn) ?? '-'), 
                              // style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(''),
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
                               Text(trackedTime.timeFormat(trackedTime.clockOut) ?? '-'),
                              // style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Worked Hours",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(trackedTime.elapsedTime ?? '-'),
                              // style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),

              //LINK DAILY
              TextButton(
                child: Center(
                  child: Container(
                    child: Text(
                      "View Daily Report",
                      style: TextStyle(color: Colors.orange, fontSize: 16),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DailyTimesheets(
                            // trackedTime: trackedTimes[_selectedDay] ?? {}
                            trackedTime: trackedTimes[_selectedDay],
                            selectedDay: _selectedDay,
                            formattedDate: formattedDate,
                            firstIn: trackedTime.clockIn,
                            lastOut: trackedTime.clockOut,
                            workedHours: trackedTime.elapsedTime,
                          )));
                },
              ),
            ],
          );
        } else {
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
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 15, right: 15),
                  child: Text("No Data Available")
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
