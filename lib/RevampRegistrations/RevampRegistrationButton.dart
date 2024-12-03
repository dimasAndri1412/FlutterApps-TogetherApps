import 'package:absent_project/MapsViews/MatterialMaps/findUserNamesAndEmailControllers.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/controller/insertRevampRegistration.dart';
import 'package:absent_project/controller/sendingEmailfunc.dart';
import 'package:absent_project/home/ApplicationBar.dart';
import 'package:absent_project/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class revampRegistrationButtons extends StatefulWidget {
  const revampRegistrationButtons({super.key});

  @override
  State<revampRegistrationButtons> createState() =>
      _revampRegistrationButtonsState();
}

class _revampRegistrationButtonsState extends State<revampRegistrationButtons> {
  void insertRegist() async {
    for (var buttonControllersss in revampResgistControllerss) {
      final revampInsertsControllers = revampInsertResgist();
      revampInsertsControllers.revampFullName = buttonControllersss["revampFullNameController"]?.text;
      revampInsertsControllers.revampUserName = buttonControllersss["revampUserNameController"]?.text;
      revampInsertsControllers.revampBirthDate = buttonControllersss["revampBirthDayController"]?.text;
      revampInsertsControllers.revampAddress = buttonControllersss["revampAddressController"]?.text;
      revampInsertsControllers.revampRoles = buttonControllersss["revampRolesController"]?.text;
      revampInsertsControllers.revampEmailAddress = buttonControllersss["revampEmailController"]?.text;
      revampInsertsControllers.revampPhoneNumber = buttonControllersss["revampPhoneNumberController"]?.text;
      revampInsertsControllers.revampPassword = buttonControllersss["revampPasswordController"]?.text;
      revampInsertsControllers.revampProjectName = buttonControllersss["revampProjectController"]?.text;
      revampInsertsControllers.revampPositionName = buttonControllersss["revampPositionController"]?.text;
      revampInsertsControllers.revampDivionName = buttonControllersss["revampDivisionController"]?.text;
      revampInsertsControllers.revampCompanyName = buttonControllersss["revampCompanyController"]?.text;
      await revampInsertsControllers.revapGegist();
    }

    if (mounted) {
      setState(() {
        for (var buttonControllersss in revampResgistControllerss) {
          buttonControllersss["revampFullNameController"]?.clear();
          buttonControllersss["revampUserNameController"]?.clear();
          buttonControllersss["revampBirthDayController"]?.clear();
          buttonControllersss["revampAddressController"]?.clear();
          buttonControllersss["revampRolesController"]?.clear();
          buttonControllersss["revampEmailController"]?.clear();
          buttonControllersss["revampPhoneNumberController"]?.clear();
          buttonControllersss["revampPasswordController"]?.clear();
          buttonControllersss["revampProjectController"]?.clear();
          buttonControllersss["revampPositionController"]?.clear();
          buttonControllersss["revampDivisionController"]?.clear();
          buttonControllersss["revampCompanyController"]?.clear();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            bool isAvailable =
            await FindUserNamesAndEmails().getUserNameAndEmail();
            if (revampRegistrationsKey.currentState!.validate()) {
              if (isAvailable) {
                insertRegist();
                const snackBar = SnackBar(
                  content: Text('Data Saved Successfully'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                sendingEmail().sendingEmailFunc();
                Get.offAll(() => ApplicationBar());
              } else {
                const snackBar = SnackBar(
                  content: Text('Email and Username is already exists!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else {
              const snackBar = SnackBar(
                content: Text('Data Failed to Save!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Container(
            height: 60,
            width: 300,
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
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
