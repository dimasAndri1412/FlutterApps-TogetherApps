import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class Timeclocktes extends StatefulWidget {
  const Timeclocktes({super.key});

  @override
  State<Timeclocktes> createState() => _TimeclocktesState();
}

class _TimeclocktesState extends State<Timeclocktes> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  // list laps = [];

  //function STOP
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //function START
  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  //function RESET ke 00
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
    });
  }

  //function Showdialog Clock Out
  void _showClockOutDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Confirm clock out?")),
            content: Text(
              "Are you sure want to Clock Out?",
              textAlign: TextAlign.center,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel  ",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        // backgroundColor: Colors.blueAccent,
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      reset();
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        // backgroundColor: Colors.blueAccent,
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 1, right: 1),
            child: Center(
              child: Text(
                "Absence",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: 150),
          Text(
            "$digitHours:$digitMinutes:$digitSeconds",
            style: TextStyle(fontSize: 80, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 150),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.blueAccent,
                  backgroundColor:
                      (!started) ? Colors.blueAccent : Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              onPressed: () {
                // (!started) ? start() : stop();
                // (!started) ? start() : reset();
                (!started) ? start() : _showClockOutDialog();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    // Icons.play_arrow_outlined,
                    (!started)
                        ? Icons.play_arrow_outlined
                        : Icons.stop_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    // "Clock in",
                    (!started) ? "Clock in" : "Clock out",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
