import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyTimesheets extends StatefulWidget {
  const DailyTimesheets({super.key});

  @override
  State<DailyTimesheets> createState() => _DailyTimesheetsState();
}

class _DailyTimesheetsState extends State<DailyTimesheets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("DAILY TIMESHEETS"),
      ),
    );
  }
}
