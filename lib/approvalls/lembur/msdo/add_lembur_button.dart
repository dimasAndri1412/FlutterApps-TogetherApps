import 'package:absent_project/approvalls/lembur/msdo/ListUserLembur.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeController.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/approvalls/lembur/msdo/pengajuan_lembur.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:get/get.dart';

class addLemburButton extends StatefulWidget {
  const addLemburButton({super.key});

  @override
  State<addLemburButton> createState() => _addLemburButtonState();
}

class _addLemburButtonState extends State<addLemburButton> {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          child: Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 124, 185, 236),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          onPressed: () {
            if (formOTKey.currentState!.validate() ||
                    formOTKeyShifting.currentState!.validate() ??
                false) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Form Approved'),
                    content: Text('The form has been submit !'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          MemberRequestOvertimeController().save();
                          Navigator.of(context).pop();
                          MemberRequestOvertimeController().clearInfo();
                          Get.offAll(ListUserLembur());
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Form is not valid')),
              );
            }
          },
        ),
      ],
    );
  }
}
