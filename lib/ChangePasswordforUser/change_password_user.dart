import 'package:absent_project/ChangePasswordforUser/change_password_user_button.dart';
import 'package:absent_project/menu/PersonalSettings/personal_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/data_controller.dart';
import '../controller/Keys.dart';

class ChangePasswordUser extends StatefulWidget {
  const ChangePasswordUser({super.key});

  @override
  State<ChangePasswordUser> createState() => _ChangePasswordUserState();
}

class _ChangePasswordUserState extends State<ChangePasswordUser> {
  bool passHide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _showConfirmDialog(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 98, 171, 232),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "CHANGES PASSWORD",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 145, 201, 247),
              Color.fromARGB(255, 98, 171, 232),
              Color.fromARGB(255, 123, 185, 235),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            // ChangesPasswordHeader(),
            Container(
              child: Image.asset(
                "assets/images/Changes_Passwords.png",
                width: 165,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  // child: ChangesPasswordWrapper(),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(70)),
                        child: SingleChildScrollView(
                          //// child: ChangesPasswordField(),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Column(
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
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black87))),
                                          child: TextFormField(
                                            controller: NewPasswordContorller,
                                            obscureText: passHide,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText: "New Password",
                                                hintText:
                                                    "Please Insert your New password",
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
                                              bool inValidPass = RegExp(
                                                      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d@$!%*?&]{10,}$')
                                                  .hasMatch(value!);

                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Password Can not Empty!";
                                              } else if (value.length < 10) {
                                                return "Password must 10 character or more";
                                              } else if (!inValidPass) {
                                                return "Password must include an uppercase letter, a lowercase letter, a number";
                                              }
                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black87))),
                                          child: TextFormField(
                                            controller:
                                                NewConfPasswordController,
                                            obscureText: passHide,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText:
                                                    "New Confirm Password",
                                                hintText:
                                                    "Please Insert your New Confirm password",
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
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Password Can not Empty!";
                                              } else if (value !=
                                                  NewPasswordContorller.text) {
                                                return "Password it's not match!";
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //// ChangesPasswordButtons()
                      ChangePasswordUserButton()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Future<bool?>> _showConfirmDialog(BuildContext context) async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Icon(Icons.warning_amber, color: Colors.deepOrange),
            title: Text(
              "Attentions!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text("ARE YOU SURE WANT TO EXIT WITHOUT SAVE"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.offAll(() => PersonalSetting());
                },
                child: Text(
                  "NO",
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.offAll(() => PersonalSetting());
                  ctr_data().clear_func();
                },
                child: Text(
                  "YES",
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }
}
