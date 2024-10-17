import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/controller/projectListContoller.dart';
import 'package:absent_project/controller/verifyOTPController.dart';
import 'package:flutter/material.dart';


class revampOTPButtons extends StatefulWidget {
  const revampOTPButtons({super.key});

  @override
  State<revampOTPButtons> createState() => _revampOTPButtonsState();
}

class _revampOTPButtonsState extends State<revampOTPButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () async {

            final otpCodeValue = await sendOTPCode();

            if(revampOTPScreenKey.currentState!.validate()) {

              if (revampOTPControllers.text == otpCodeValue) {
                verifyOTPController().verifyOTP();
              } else {
                final snackBar = SnackBar(content: Text("OTP Code Not Match"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

            } else {
              ctr_data().clear_func();
            }
          },
          child: Container(
              height: 50,
              width: 300,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'CONFIRM',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),

                ),
              )
          ),
        )
      ],
    );
  }
}
