import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GmapsElapsedTimeWrapper.dart';
import 'package:flutter/material.dart';

class gmapsElapsedTimesPages extends StatefulWidget {
  const gmapsElapsedTimesPages({super.key});

  @override
  State<gmapsElapsedTimesPages> createState() => _gmapsElapsedTimesPagesState();
}

class _gmapsElapsedTimesPagesState extends State<gmapsElapsedTimesPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gmapsElapsedTimesWrapper(),
    );
  }
}
