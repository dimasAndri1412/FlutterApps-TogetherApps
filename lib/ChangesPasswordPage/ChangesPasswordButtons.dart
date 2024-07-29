import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/data_controller.dart';
import 'package:absent_project/ChangesPasswordPage/ChangesPasswordCamera.dart';
import 'dart:io';

class ChangesPasswordButtons extends StatefulWidget {
  // const ChangesPasswordButtons({super.key});

  // final File? image;
  // final bool faceDetected;

  // const ChangesPasswordButtons({
  //   super.key,
  //   required this.image,
  //   required this.faceDetected,
  // });

  @override
  State<ChangesPasswordButtons> createState() => _ChangesPasswordButtonsState();
}

class _ChangesPasswordButtonsState extends State<ChangesPasswordButtons> {
  final Changespasswordcamera _cameraState = Changespasswordcamera(); 
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (formsKeys.currentState!.validate()) {
              ctr_data().update_pwd().then((value) {
                if (value) {
                  final snackBar =
                      SnackBar(content: const Text("Password Success Changes"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  ctr_data().clear_func();
                  Get.offAll(() => const LoginPage());
                } else {
                  final snackBar = SnackBar(
                      content: const Text("Password Failure Changes!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              });
            }
          },
          child: Container(
              height: 50,
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'SAVE',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ],
    );
  }
}
