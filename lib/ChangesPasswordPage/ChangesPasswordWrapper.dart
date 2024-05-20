import 'package:absent_project/ChangesPasswordPage/ChangesPasswordButtons.dart';
import 'package:absent_project/ChangesPasswordPage/ChangesPasswordField.dart';
import 'package:flutter/material.dart';

class ChangesPasswordWrapper extends StatefulWidget {
  const ChangesPasswordWrapper({super.key});

  @override
  State<ChangesPasswordWrapper> createState() => _ChangesPasswordWrapperState();
}

class _ChangesPasswordWrapperState extends State<ChangesPasswordWrapper> {
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
                borderRadius: BorderRadius.circular(70)
              ),
              child: SingleChildScrollView(
                child: ChangesPasswordField(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ChangesPasswordButtons()
          ],
        ),
    );
  }
}
