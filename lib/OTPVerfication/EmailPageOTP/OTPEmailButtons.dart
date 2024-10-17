import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/OTPController.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/controller/projectListContoller.dart';
import 'package:flutter/material.dart';

class OTPEmailButtons extends StatefulWidget {
  const OTPEmailButtons({super.key});

  @override
  State<OTPEmailButtons> createState() => _OTPEmailButtonsState();
}

class _OTPEmailButtonsState extends State<OTPEmailButtons> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () async {

            final emailValue = await validationUserEmails();

            if(emailFormOtp.currentState!.validate() && EmailController.text == emailValue) {
              OtpControllers().SendOtpCode();
            } else {
              final snackBar = SnackBar(content: Text("Could not Sent OTP!"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  'SEND OTP TO EMAIL',
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
