import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPCodeField extends StatefulWidget {
  const OTPCodeField({super.key});

  @override
  State<OTPCodeField> createState() => _OTPCodeFieldState();
}

class _OTPCodeFieldState extends State<OTPCodeField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Form(
          key: otpFormsKeys,
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black87))),
                  child: TextFormField(
                    controller: OTPController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "OTP",
                        hintText: "Please Insert OTP",
                        hintStyle: TextStyle(
                            color: Colors.black26),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.code)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "OTP Can not Empty!";
                      }
                      return null;
                    },
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}