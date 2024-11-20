import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/controller/insertRevampRegistration.dart';
import 'package:absent_project/controller/sendingEmailfunc.dart';
import 'package:absent_project/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class revampRegistrationButtons extends StatefulWidget {
  const revampRegistrationButtons({super.key});

  @override
  State<revampRegistrationButtons> createState() => _revampRegistrationButtonsState();
}

class _revampRegistrationButtonsState extends State<revampRegistrationButtons> {

  void insertRegist() async{
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
            onTap: (){
              if (revampRegistrationsKey.currentState!.validate()) {
                insertRegist();
                const snackBar = SnackBar(
                  content: Text('Data Berhasil Disimpan'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                sendingEmail().sendingEmailFunc();
                //clearInsertRegist();
                Get.offAll(() => LoginPage());
              } else{
                const snackBar = SnackBar(
                  content: Text('Data Gagal Disimpan'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              };
            } ,
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
                )
            ),
        )
      ],
    );
  }
}
