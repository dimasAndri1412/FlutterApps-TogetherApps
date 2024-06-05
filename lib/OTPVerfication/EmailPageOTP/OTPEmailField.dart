import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';

import '../../controller/projectListContoller.dart';

class OTPEmailPage extends StatefulWidget {
  const OTPEmailPage({super.key});

  @override
  State<OTPEmailPage> createState() => _OTPEmailPageState();
}

class _OTPEmailPageState extends State<OTPEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Form(
            key: emailFormOtp,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black87)
                  )
              ),
              child: TextFormField(
                controller: EmailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Please Insert Your Email",
                    hintStyle: TextStyle(color: Colors.black26),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.mail)),
                validator: (value) {
                  //validator format email
                  bool inValidEmail = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                  if (value == null || value.isEmpty) {
                    return 'Email Can not empty!';
                  } else if (!inValidEmail) {
                    EmailController.clear();
                    return "Incorrect Email format";
                  }
                  return null;

                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
