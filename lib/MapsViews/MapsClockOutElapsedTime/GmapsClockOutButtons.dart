import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GmapsElapsedTimePages.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationPage.dart';
import 'package:absent_project/MapsViews/MatterialMaps/GmapsStopWatchController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class gmapsClockOutButtons extends StatefulWidget {
  const gmapsClockOutButtons({super.key});

  @override
  State<gmapsClockOutButtons> createState() => _gmapsClockOutButtonsState();
}

class _gmapsClockOutButtonsState extends State<gmapsClockOutButtons> {

  final stopWatchControllers = Get.put(gmapsStopWatchController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            stopWatchControllers.resetStopwatch();
            Get.offAll(() => gmapsLocationPages());
          },
          child: Container(
            height: 50,
            width: 250,
            margin: EdgeInsets.symmetric(
              horizontal: 50,
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Center(
              child: Text(
                "Clock Out",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
