import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GampsElapsedTimeMapsView.dart';
import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GmapsElapsedTimeField.dart';
import 'package:absent_project/MapsViews/MatterialMaps/GmapsStopWatchController.dart';
import 'package:absent_project/attendance/CameraDetection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class gmapsElapsedTimesWrapper extends StatefulWidget {
  const gmapsElapsedTimesWrapper({super.key});

  @override
  State<gmapsElapsedTimesWrapper> createState() => _gmapsElapsedTimesWrapperState();
}


class _gmapsElapsedTimesWrapperState extends State<gmapsElapsedTimesWrapper> {

  final stopWatchControllers = Get.put(gmapsStopWatchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                    child: gmapsElapsedTimeMapsView()
                ),
              ],
            ),
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Container(
                height: 145,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 30),
                        blurRadius: 80,
                        color: Colors.black26
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: gmapsElapsedTimesField(),
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            stopWatchControllers.stopStopwatch();
            Get.to(() => CameraDetection());
          },
          label: Text(
            "Stop",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: Colors.redAccent,
          icon: Icon(
            Icons.stop,
            color: Colors.white,
          ),
        )
    );
  }
}
