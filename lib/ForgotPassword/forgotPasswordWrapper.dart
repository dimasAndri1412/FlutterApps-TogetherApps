import 'package:absent_project/ForgotPassword/forgotPasswordButtons.dart';
import 'package:absent_project/ForgotPassword/forgotPasswordFields.dart';
import 'package:flutter/material.dart';

class forgotPasswordWrapper extends StatefulWidget {
  const forgotPasswordWrapper({super.key});

  @override
  State<forgotPasswordWrapper> createState() => _forgotPasswordWrapperState();
}

class _forgotPasswordWrapperState extends State<forgotPasswordWrapper> {
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
              child: forgotPasswordField(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          forgotPasswordButtons()
        ],
      ),
    );
  }
}
