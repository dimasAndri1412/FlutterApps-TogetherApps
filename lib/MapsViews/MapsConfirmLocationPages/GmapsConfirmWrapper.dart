import 'package:absent_project/MapsViews/MapsConfirmLocationPages/GmapsConfirmButtons.dart';
import 'package:absent_project/MapsViews/MapsConfirmLocationPages/GmapsConfirmField.dart';
import 'package:flutter/material.dart';


class gmapsConfirmWrappers extends StatefulWidget {
  const gmapsConfirmWrappers({super.key});

  @override
  State<gmapsConfirmWrappers> createState() => _gmapsConfirmWrappersState();
}

class _gmapsConfirmWrappersState extends State<gmapsConfirmWrappers> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(60),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
              ),
              child: SingleChildScrollView(
                child: gmapsConfirmField(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            gmapsConfirmButtons()
          ],
        ),
    );
  }
}
