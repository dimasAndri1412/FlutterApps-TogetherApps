import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/ListTimesheetsController.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/ListTimesheetsModel.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:absent_project/timesheets/AdminPage/DailyTimeheets.dart';

class WorkShift {
  final String name;
  final String clockIn;
  final String clockOut;
  final String imageUrl;

  WorkShift({required this.name, required this.clockIn, required this.clockOut, required this.imageUrl});

  String getTotalHours() {
    try {
      final clockInTime = DateFormat('HH:mm').parse(clockIn);
      final clockOutTime = DateFormat('HH:mm').parse(clockOut);

      final duration = clockOutTime.difference(clockInTime);
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);

      return '$hours h $minutes m';
    } catch (e) {
      return 'Invalid time';
    }
  }

  String getStatus() {
    return '$clockIn - $clockOut';
  }
}

class Timesheets extends StatefulWidget {
  const Timesheets({super.key});

  @override
  State<Timesheets> createState() => _TimesheetsState();
}

class _TimesheetsState extends State<Timesheets> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime today = DateTime.now();
  DateTime? _selectedDay; 

  late Future<List<ListTimesheetsModel>> _listTimesheets;
  ListTimesheetsController listTimesheetsController = ListTimesheetsController();

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      today = focusedDay;
      _listTimesheets = listTimesheetsController.getList(_selectedDay!);
    });
  }

  void _onPageChanged(DateTime focusedDay) {
    setState(() {
      today = focusedDay;
      _selectedDay = null;
      _fetchDataForCurrentFormat();
    });
  }

  void _initializeListTimesheets(){
    // _listTimesheets = listTimesheetsController.getList(today);
    _fetchDataForCurrentFormat();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeListTimesheets();
  }

  void _onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      setState(() {
        _calendarFormat = format;
        _fetchDataForCurrentFormat(); 
      });
    }
  }

  void _fetchDataForCurrentFormat() {
    if (_calendarFormat == CalendarFormat.week) {
      DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
      _listTimesheets = listTimesheetsController.getListFilter(startOfWeek, endOfWeek);
    } else if (_calendarFormat == CalendarFormat.month) {
      DateTime startOfMonth = DateTime(today.year, today.month, 1);
      DateTime endOfMonth = DateTime(today.year, today.month + 1, 0);
      _listTimesheets = listTimesheetsController.getListFilter(startOfMonth, endOfMonth);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    // final DateFormat formatter = DateFormat('EE, d MMM yyyy');
    // final String formattedDate = formatter.format(_selectedDay);
    final String formattedDate = _selectedDay != null
        ? DateFormat('EE, d MMM yyyy').format(_selectedDay!) 
        : DateFormat('MMMM yyyy').format(today); 

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            calendar(),
            Container(
              child: Text(
                formattedDate,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: FutureBuilder(
                  future: _listTimesheets, 
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(),);
                    } else if (snapshot.hasError){
                      return Center(child: Text("Error: ${snapshot.error}"),);
                    } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty){
                      return Center(child: Text("No Data Available"),);
                    }

                    final timesheet = snapshot.data!;
                    return ListView.builder(
                      itemCount: timesheet.length,
                      itemBuilder: (context, index) {
                        final list = timesheet[index];
                        String? clock_in = list.clockIn != null ? DateFormat('HH:mm').format(list.clockIn!) : null;
                        String? clock_out = list.clockOut != null ? DateFormat('HH:mm').format(list.clockOut!) : null;

                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => DailyTimesheets(
                                selectedDay: list.clockIn,
                                clockInId: list.clockInID,
                                )));
                          },
                          child: ListTile (
                            /*imageUrl: "https://picsum.photos/id/$index/200/300",*/
                            title:Text(list.fullName ?? "n/a"),
                            subtitle: Text("${clock_in} - ${clock_out ?? "null"}" ?? "n/a"),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(list.imagePath),
                            ),
                            trailing:Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(list.elapsedTime ?? "total"),
                                SizedBox(width: 10,),
                                Icon(Icons.chevron_right, color: Colors.grey,),
                              ],
                            )
                          )
                        );
                      }
                    );
                  }
                )
              )
            )
          ],
        ),
      )
    );
  }

  Widget calendar(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          // Text("Selected Day = " + today.toString().split(" ")[0]),
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              focusedDay: today, 
              firstDay: DateTime.utc(2019, 10, 16), 
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
              calendarFormat: _calendarFormat,
              onFormatChanged: _onFormatChanged,
              onPageChanged: _onPageChanged,
            ),
          )
        ],
      ),
    );
  }
}