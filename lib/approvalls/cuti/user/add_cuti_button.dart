import 'package:absent_project/approvalls/cuti/user/list_pengajuan_cuti.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeave.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:get/get.dart';
import 'list_pengajuan_cuti.dart';

class addCutiButton extends StatefulWidget {
  const addCutiButton({super.key});

  @override
  State<addCutiButton> createState() => _addCutiButtonState();
}

class _addCutiButtonState extends State<addCutiButton> {
/*  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MemberRequestPaidLeaveController().getLeave();
  }*/
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
            if (formKeyss_.currentState!.validate() ?? false) {
              if (remaining_leave.text != "0") {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Form Approved'),
                      content: Text('The form has been submit !'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            MemberRequestPaidLeaveController().save();
                            Navigator.of(context).pop();
                            MemberRequestPaidLeaveController().clearInfo();
                            Get.offAll(const ListPengajuanCuti());
                            // const ListPengajuanCuti();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("You dont have any leave left")),
                );
                MemberRequestPaidLeaveController().clearInfo();
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Form is not valid')),
              );
            }
          },
        ),
      ],
    );
  }
}
