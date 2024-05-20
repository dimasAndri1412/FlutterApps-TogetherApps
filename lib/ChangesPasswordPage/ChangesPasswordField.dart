import 'dart:ui';

import 'package:absent_project/ChangesPasswordPage/ChangesPasswordButtons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/Keys.dart';

class ChangesPasswordField extends StatefulWidget {
  const ChangesPasswordField({super.key});

  @override
  State<ChangesPasswordField> createState() => _ChangesPasswordFieldState();
}

class _ChangesPasswordFieldState extends State<ChangesPasswordField> {
  bool passHide = false;

  void iniState() {
    super.initState();
    passHide = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Form(
            key: formsKeys,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black87))),
                  child: TextFormField(
                    controller: NewPasswordContorller,
                    obscureText: passHide,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "New Password",
                        hintText: "Please Insert your New password",
                        hintStyle: TextStyle(
                          color: Colors.black12,
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(passHide
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passHide = !passHide;
                            });
                          },
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password Can not Empty!";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black87))),
                  child: TextFormField(
                    controller: NewConfPasswordController,
                    obscureText: passHide,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "New Confirm Password",
                        hintText: "Please Insert your New Confirm password",
                        hintStyle: TextStyle(
                          color: Colors.black12,
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(passHide
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passHide = !passHide;
                            });
                          },
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password Can not Empty!";
                      } else if (value != NewPasswordContorller.text) {
                        return "Password it's not match!";
                      }
                    },
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
