import 'dart:ffi';
import 'dart:ui';

import 'package:absent_project/ChangesPasswordPage/ChangesPasswordButtons.dart';
import 'package:absent_project/controller/KPIQuestionsController/position/PositionController.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/controller/KPIQuestionsController/position/PositionModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Keys.dart';

class ChangesPasswordField extends StatefulWidget {
  const ChangesPasswordField({super.key});

  @override
  State<ChangesPasswordField> createState() => _ChangesPasswordFieldState();
}

class _ChangesPasswordFieldState extends State<ChangesPasswordField> {
  bool passHide = true;
  List<positionModel> positions = [];
  final PositionController positionController = Get.put(PositionController());
  int? selectedPosition;
  bool isLoading = true;

  void initState() {
    super.initState();
    positionController.fetchPositions();
    // fetchPositions();
  }

  // Future<void> fetchPositions() async {
  //   try{
  //     List<positionModel> data = await _dataController.fetchPositions();
  //     setState(() {
  //       positions = data;
  //       isLoading = false;
  //     });
  //     data.forEach((position) {
  //       print('ID: ${position.idPosition}, Name: ${position.positionName}');
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print('error : $e');
  //   }
  // }

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

                      bool inValidPass = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d@$!%*?&]{10,}$').hasMatch(value!);

                      if (value == null || value.isEmpty) {
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
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black87))),
                  child: Obx(() {
                    if (positionController.isLoading.value) {
                      return CircularProgressIndicator(); 
                    } else if (positionController.errorMessage.isNotEmpty) {
                      return Text(positionController.errorMessage.value);
                    } else {
                      return DropdownButtonFormField<int>(
                        items: positionController.positions.map((position) {
                          return DropdownMenuItem<int>(
                            value: position.idPosition,
                            child: Text(position.positionName),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.work),
                        ),
                        value: positionController.selectedPosition.value,
                        onChanged: (value) {
                          setState(() {
                            positionController.setPosition(value);
                            print(value);
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please Select Position";
                          }
                          return null;
                        },
                      );
                    }
                  }),
                ),
              ],
            ))
      ],
    );
  }
}
