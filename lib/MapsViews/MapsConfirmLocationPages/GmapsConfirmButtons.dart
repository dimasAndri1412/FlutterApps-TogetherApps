import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GmapsElapsedTimePages.dart';
import 'package:absent_project/MapsViews/MatterialMaps/GmapsStopWatchController.dart';
import 'package:absent_project/MapsViews/MatterialMaps/VerifyUsersLoginMaps.dart';
import 'package:absent_project/MapsViews/MatterialMaps/insertClockInControllers.dart';
import 'package:absent_project/controller/AbsentController/ClockInController.dart';
import 'package:absent_project/controller/AbsentController/ClockInState.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/home/ApplicationBarClockIn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


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
              ClockInController().clock_in().then((value) {
                print("Clock In Result: $value");
                if (value) {
                  Provider.of<ClockInState>(context, listen: false).clockIn();
                  final snackBar =
                  SnackBar(
                      content: const Text("Success Clock In")
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  stopWatchControll.startStopwatch();
                  //insertClockInControllers().insertClockInValues();
                  ctr_data().clear_maps_clock_in_out_func();
                  verifyRolesClockIn().verifyRolesUsersClockIn();
                } else {
                  final snackBar = SnackBar(
                      content: const Text("Failure Clock In!")
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              });
              // Get.offAll(() => gmapsElapsedTimesPages());
              // stopWatchControll.startStopwatch();
            }
          },
          child: Container(
            height: 50,
            width: 350,
            // margin: EdgeInsets.symmetric(
            //   horizontal: 50
            // ),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text(
                "Clock In",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
