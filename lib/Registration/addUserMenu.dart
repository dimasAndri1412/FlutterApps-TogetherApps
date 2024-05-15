import 'package:absent_project/Registration/addUserHeader.dart';
import 'package:absent_project/Registration/addUserWrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/Keys.dart';
import 'package:get/get.dart';


class addUserMenu extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return WillPopScope (
        onWillPop: () async {
          bool shouldPop = await _showExitConfirm(context);
          return shouldPop;
        },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 98, 171, 232),
          iconTheme: IconThemeData(color: Colors.white),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios, color: Colors.white,),
            onTap: () {
              _showExitConfirm(context);
            },
          ),
          title: Text("PERSONAL INFORMATION",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromARGB(255, 145, 201, 247),
              Color.fromARGB(255, 98, 171, 232),
              Color.fromARGB(255, 123, 185, 235),
              Color.fromARGB(255, 255, 255, 255),
            ]),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              addUserMenu(),
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only (
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      )
                    ),
                    child: SingleChildScrollView(
                      child: addUserWrapper(),
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> _showExitConfirm(BuildContext context) async {
    bool shouldPop = false;
    await Get.dialog(
      AlertDialog(
        title: Text("Confirmation",
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                shouldPop = false;
                Get.back();
              },
              child: Text("NO",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              )
          ),
          TextButton(
              onPressed: () {
                Get.back();
                FullNameController.clear();
                UserNameController.clear();
                BirthDateController.clear();
                AddressController.clear();
                RolesController.clear();
                PhoneNumbersController.clear();
                EmailController.clear();
                PassController.clear();
                ConfPassController.clear();
                Get.back();
              },
              child: Text("YES",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
          ),
        ],
      )
    );
    return shouldPop;
  }
}


