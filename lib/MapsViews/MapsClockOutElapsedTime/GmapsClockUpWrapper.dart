import 'package:absent_project/MapsViews/MapsClockOutElapsedTime/GmapsClockOutButtons.dart';
import 'package:absent_project/MapsViews/MapsClockOutElapsedTime/GmapsClockOutField.dart';
import 'package:flutter/material.dart';

class gmapsClockOutWrapper extends StatefulWidget {
  const gmapsClockOutWrapper({super.key});

  @override
  State<gmapsClockOutWrapper> createState() => _gmapsClockOutWrapperState();
}


class _gmapsClockOutWrapperState extends State<gmapsClockOutWrapper> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
              ),
              child: SingleChildScrollView(
                child: gmapsClockOutField(),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            gmapsClockOutButtons()
          ],
        ),
    );
  }
}
