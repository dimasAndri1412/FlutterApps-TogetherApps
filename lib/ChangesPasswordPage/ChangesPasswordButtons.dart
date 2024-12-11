import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/KPIQuestionsController/position/PositionController.dart';
import 'package:absent_project/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/data_controller.dart';
import 'package:absent_project/ChangesPasswordPage/ChangesPasswordCamera.dart';

class ChangesPasswordButtons extends StatefulWidget {
  // const ChangesPasswordButtons({super.key});

  // final File? image;
  // final bool faceDetected;

  // const ChangesPasswordButtons({
  //   super.key,
  //   required this.image,
  //   required this.faceDetected,
  // });
  ChangesPasswordButtons({super.key});
  @override
  State<ChangesPasswordButtons> createState() => _ChangesPasswordButtonsState();
}

class _ChangesPasswordButtonsState extends State<ChangesPasswordButtons> {
  // final Changespasswordcamera _cameraState = Changespasswordcamera(); 
  final PositionController positionController = Get.find();

  void checkPassword() async {
    final checkPass = await verifyPasswordControllers() ?? '';
    PasswordValidateControllers.text = checkPass;

    if (NewPasswordContorller.text != PasswordValidateControllers.text ||
        PasswordValidateControllers.text.isEmpty) {
      ctr_data().change_pwd().then((value) {
        if (value) {
          final snackBar = SnackBar(content: const Text("Password Success Changes"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          ctr_data().clear_func_otp();
          Get.offAll(() => const LoginPage());
          PasswordValidateControllers.clear();
        } else {
          final snackBar = SnackBar(content: const Text("Password Failure Changes!"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }).catchError((error) {
        print("Exception during change_pwd request: $error");
        final snackBar = SnackBar(content: Text("Error: ${error.toString()}"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
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
          onTap: () async {
            if (formsKeys.currentState!.validate()) {
              checkPassword();
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
