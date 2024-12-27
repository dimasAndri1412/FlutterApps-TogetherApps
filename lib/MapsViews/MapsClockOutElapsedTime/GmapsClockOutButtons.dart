import 'package:absent_project/MapsViews/MatterialMaps/GmapsStopWatchController.dart';
import 'package:absent_project/MapsViews/MatterialMaps/VerifyUsersLogOutMaps.dart';
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

  Future<void> clearClockInStatus() async {
    await secureStorage.delete(key: 'isClockIn');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            if (gmapsClockConfirmKey.currentState!.validate() &&
                questionKey.currentState!.validate()) {
              ClockInController().clock_out().then((value) async {
                if (value) {
                  Provider.of<ClockInState>(context, listen: false).clockOut();
                  stopWatchControllers.resetStopwatch();
                  answerController.clear();
                  verifyRolesClockOut().verifyRolesUsersClockOut();
                  await clearClockInStatus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Success Clock Out")),
                  );
                  print("Clock Out and stopwatch reset completed.");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failure Clock Out!")),
                  );
                  answerController.clear();
                  print("Clock Out failed.");
                }
              });
            }
          },
          child: Container(
            height: 50,
            width: 250,
            margin: const EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                "Clock Out",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
