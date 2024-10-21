import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/controller/projectListContoller.dart';
import 'package:absent_project/controller/verifyOTPController.dart';
import 'package:flutter/material.dart';

class OTPCodeButtons extends StatefulWidget {
  const OTPCodeButtons({super.key});

  @override
  State<OTPCodeButtons> createState() => _OTPCodeButtonsState();
}

class _OTPCodeButtonsState extends State<OTPCodeButtons> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () async {

            setState(() {
              isLoading = true;
            });

            final otpCodeValue = await sendOTPCode();

            if(otpFormsKeys.currentState!.validate() && OTPController.text == otpCodeValue) {
              verifyOTPController().verifyOTP();
            } else {
              final snackBar = SnackBar(content: Text("OTP Code Not Match"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              ctr_data().clear_func();
            }

            setState(() {
              isLoading = false;
            });
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
                child: isLoading ?
                    CircularProgressIndicator(
                      color: Colors.white,
                    ) : Text(
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
