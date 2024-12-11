import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/sendingEmailForgotPassword.dart';
import 'package:absent_project/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/data_controller.dart';

class forgotPasswordButtons extends StatefulWidget {
  const forgotPasswordButtons({super.key});

  @override
  State<forgotPasswordButtons> createState() => _forgotPasswordButtonsState();
}

class _forgotPasswordButtonsState extends State<forgotPasswordButtons> {

  void checkPassworForgots() async {
    final checkPass = await verifyPasswordControllers() ?? '';
    PasswordValidateControllers.text = checkPass;

    if (NewPasswordContorller.text != PasswordValidateControllers.text ||
        PasswordValidateControllers.text.isEmpty) {

      final snackBar =
      SnackBar(content: const Text("Password Success Changes"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      sendingEmailForgotPassword().sendingEmailForgotPasswordFunc();
      ctr_data().forgot_pwd();
      ctr_data().clear_func();
      Get.offAll(() => LoginPage());

    } else {
      final snackBar = SnackBar(content: const Text("Password Has Been Used"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      NewPasswordContorller.clear();
      NewConfPasswordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (formsForgotKeys.currentState!.validate()) {

              checkPassworForgots();

            } else {
              final snackBar =
              SnackBar(content: const Text("Password Changes Failed"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              ctr_data().clear_func();
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
              )
          ),
        ),
      ],
    );
  }
}
