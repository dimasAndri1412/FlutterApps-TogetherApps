import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Timesheets extends StatefulWidget {
  const Timesheets({super.key});

  @override
  State<Timesheets> createState() => _TimesheetsState();
}

class _TimesheetsState extends State<Timesheets> {
  CalendarFormat _calendarFormat =CalendarFormat.month;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            calendar(),
            Padding(
              padding: EdgeInsets.all(10),
              child: ListTile (
                /*imageUrl: "https://picsum.photos/id/$index/200/300",*/
                title:Text("Razu"),
                subtitle: Text("Did not clock in"),
                leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 150, 199, 239),
                ),
                trailing:Icon(Icons.chevron_right, color: Colors.grey,),
              ),
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