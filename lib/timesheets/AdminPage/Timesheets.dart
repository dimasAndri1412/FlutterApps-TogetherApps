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
  CalendarFormat _calendarFormat =CalendarFormat.week;
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day,DateTime focusedDay){
    setState(() {
      today= day;
    });
  }

  void _onFormatChanged(format){
    if (_calendarFormat != format) {
      setState(() => _calendarFormat = format);
    }
  }

  List<WorkShift> workShifts = [
    WorkShift(name: "Razu", clockIn: "08:12", clockOut: "17:10", imageUrl: "https://cdn.idntimes.com/content-images/community/2017/05/4-632faff4ffaa3e16ec532c27fc8fbdb6_600x400.jpg"),
    WorkShift(name: "Beomgyu", clockIn: "09:30", clockOut: "19:21", imageUrl: "https://shopee.co.id/inspirasi-shopee/wp-content/uploads/2021/11/8A230920-1288-4933-97EF-ACBE94EBFD63kpoping-1.webp"),
    WorkShift(name: "Sunoo", clockIn: "07:30", clockOut: "18:16", imageUrl: "https://i.pinimg.com/originals/2a/24/cb/2a24cb2bc385494be1d7958c72a762d6.jpg"),
    WorkShift(name: "Jungkook", clockIn: "09:16", clockOut: "19:04", imageUrl: "https://w0.peakpx.com/wallpaper/280/151/HD-wallpaper-bts-jungkook-kookie.jpg"),
    WorkShift(name: "Chanyoung", clockIn: "08:16", clockOut: "17:04", imageUrl: "https://i.mydramalist.com/q4qg5_5f.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            calendar(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  itemCount: workShifts.length,
                  itemBuilder: (context, index) {
                    final workShift = workShifts[index];
                    return GestureDetector(
                      onTap: (){
                         Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => DailyTimesheets()));
                      },
                      child: ListTile (
                        /*imageUrl: "https://picsum.photos/id/$index/200/300",*/
                        title:Text(workShift.name),
                        subtitle: Text(workShift.getStatus()),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(workShift.imageUrl),
                        ),
                        trailing:Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(workShift.getTotalHours()),
                            SizedBox(width: 10,),
                            Icon(Icons.chevron_right, color: Colors.grey,),
                          ],
                        )
                      )
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
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today, 
              firstDay: DateTime.utc(2019, 10, 16), 
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
              calendarFormat: _calendarFormat,
              onFormatChanged: _onFormatChanged,
            ),
          )
        ],
      ),
    );
  }
}