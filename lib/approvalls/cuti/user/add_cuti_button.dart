import 'package:absent_project/approvalls/cuti/user/list_pengajuan_cuti.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeave.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:get/get.dart';
import 'list_pengajuan_cuti.dart';
import 'package:intl/intl.dart';

class addCutiButton extends StatefulWidget {
  final String selectedShift;
  const addCutiButton({required this.selectedShift, super.key});

  @override
  State<addCutiButton> createState() => _addCutiButtonState();
}

class _addCutiButtonState extends State<addCutiButton> {
  final MemberRequestPaidLeaveController leaveInfo =
      MemberRequestPaidLeaveController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: leaveInfo.getLeaveNew(),
      builder: (context, snapshot) {
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
                  if (startDatePaidLeave.text.isNotEmpty &&
                      endDatePaidLeave.text.isNotEmpty) {
                    DateTime startDate =
                        DateFormat('yyyy-MM-dd').parse(startDatePaidLeave.text);
                    DateTime endDate =
                        DateFormat('yyyy-MM-dd').parse(endDatePaidLeave.text);

                    if (widget.selectedShift == "Non shift") {
                      int calculateWorkDays(DateTime start, DateTime end) {
                        int workDays = 0;
                        DateTime currentDate = start;

                        while (currentDate.isBefore(end) ||
                            currentDate.isAtSameMomentAs(end)) {
                          if (currentDate.weekday != DateTime.saturday &&
                              currentDate.weekday != DateTime.sunday) {
                            workDays++;
                          }
                          currentDate = currentDate.add(Duration(days: 1));
                        }
                        return workDays;
                      }

                      int totalWorkDays = calculateWorkDays(startDate, endDate);
                      if (totalWorkDays > leaveInfo.remainingLeave) {
                        print("gak bisa cuti");
                        print("total hari: $totalWorkDays");
                        print("sisah cuti: ${leaveInfo.remainingLeave}");

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "You cannot take more leave than your remaining leave")));
                      } else if (leaveInfo.remainingLeave != 0) {
                        print("berhasil NON-shifting");
                        print("total hari: $totalWorkDays");
                        print("sisah cuti: ${leaveInfo.remainingLeave}");
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Form Approved'),
                              content: Text('The form has been submit !'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    MemberRequestPaidLeaveController()
                                        .saveNonShift();
                                    Navigator.of(context).pop();
                                    MemberRequestPaidLeaveController()
                                        .clearInfo();
                                    Get.offAll(const ListPengajuanCuti());
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else if (widget.selectedShift == "Shift I" ||
                        widget.selectedShift == "Shift II" ||
                        widget.selectedShift == "Shift III") {
                      Duration difference = endDate.difference(startDate);

                      if (difference.inDays + 1 > leaveInfo.remainingLeave) {
                        print("gak bisa cuti");
                        print("total hari: ${difference.inDays + 1}");
                        print("sisah cuti: ${leaveInfo.remainingLeave}");

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "You cannot take more leave than your remaining leave")));
                      } else if (leaveInfo.remainingLeave != 0) {
                        print("berhasil shifting");
                        print("total hari: ${difference.inDays + 1}");
                        print("sisah cuti: ${leaveInfo.remainingLeave}");
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Form Approved'),
                              content: Text('The form has been submit !'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      MemberRequestPaidLeaveController().save();
                                      Navigator.of(context).pop();
                                      MemberRequestPaidLeaveController()
                                          .clearInfo();
                                      Get.offAll(const ListPengajuanCuti());
                                    },
                                    child: Text('OK')),
                              ],
                            );
                          },
                        );
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("You dont have any leave left")),
                    );
                    // MemberRequestPaidLeaveController().clearInfo();
                    print("total remaining leave: ${leaveInfo.remainingLeave}");
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
      },
    );
  }
}
