import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/home/applicationbar_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/data_controller.dart';
import 'package:absent_project/controller/Keys.dart';

class ChangePasswordUserButton extends StatefulWidget {
  const ChangePasswordUserButton({super.key});

  @override
  State<ChangePasswordUserButton> createState() =>
      _ChangePasswordUserButtonState();
}

class _ChangePasswordUserButtonState extends State<ChangePasswordUserButton> {

  void checkPasswordUsers() async {
    final checkPass = await verifyPasswordControllers() ?? '';
    PasswordValidateControllers.text = checkPass;

    if (NewPasswordContorller.text != PasswordValidateControllers.text ||
        PasswordValidateControllers.text.isEmpty) {
      ctr_data().change_pwd().then((value) {
        if (value) {
          final snackBar =
          SnackBar(content: const Text("Password Success Changes"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          ctr_data().clear_func();
          Get.offAll(() => const ApplicationBarUser());
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
          onTap: () {
            if (formsKeys.currentState!.validate()) {
              checkPasswordUsers();
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
