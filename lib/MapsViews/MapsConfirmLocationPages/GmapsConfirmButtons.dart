import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GmapsElapsedTimePages.dart';
import 'package:absent_project/MapsViews/MatterialMaps/GmapsStopWatchController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class gmapsConfirmButtons extends StatefulWidget {
  const gmapsConfirmButtons({super.key});

  @override
  State<gmapsConfirmButtons> createState() => _gmapsConfirmButtonsState();
}

class _gmapsConfirmButtonsState extends State<gmapsConfirmButtons> {

  final stopWatchControll = Get.put(gmapsStopWatchController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if(gmapsConfirmKey.currentState!.validate()) {
              Get.offAll(() => gmapsElapsedTimesPages());
              stopWatchControll.startStopwatch();
            }
          },
          child: Container(
            height: 50,
            width: 250,
            margin: EdgeInsets.symmetric(
              horizontal: 50
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Center(
              child: Text(
                "Clock In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
