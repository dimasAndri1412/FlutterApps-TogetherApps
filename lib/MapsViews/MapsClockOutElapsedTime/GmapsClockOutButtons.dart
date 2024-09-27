import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GmapsElapsedTimePages.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationPage.dart';
import 'package:absent_project/MapsViews/MatterialMaps/GmapsStopWatchController.dart';
import 'package:absent_project/controller/AbsentController/ClockInController.dart';
import 'package:absent_project/controller/AbsentController/ClockInState.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
             if(gmapsConfirmKey.currentState!.validate()){
              ClockInController().clock_out().then((value) {
                print("Clock Out Result: $value");
                if (value) {
                  Provider.of<ClockInState>(context, listen: false).clockOut();
                  final snackBar =
                    SnackBar(
                      content: const Text("Success Clock Out")
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Get.offAll(() => const gmapsLocationPages());
                } else {
                  final snackBar = SnackBar(
                    content: const Text("Failure Clock Out!")
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              });
             }
            // Get.offAll(() => gmapsLocationPages());
            
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
