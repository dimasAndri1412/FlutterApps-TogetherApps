import 'dart:convert';
import 'package:absent_project/approvalls/cuti/user/edit_add_cuti_button.dart';
import 'package:absent_project/approvalls/cuti/user/list_pengajuan_cuti.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberListPaidLeave.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeave.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditPengajuanCuti extends StatefulWidget {
  final MemberListPaidLeave currentMember;
  const EditPengajuanCuti({super.key, required this.currentMember});

  @override
  State<EditPengajuanCuti> createState() => _EditPengajuanCutiState();
}

class _EditPengajuanCutiState extends State<EditPengajuanCuti> {
  final MemberRequestPaidLeaveController request =
      MemberRequestPaidLeaveController();

  int countEdit = 0;
  int leaveUsed = 0;
  int remainingLeave = 0;
  int countStatus = 0;
  int initial = 0;
  int totalLeave = 12;

  getTemporary() async {
    var getTempo = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getTemporary.php"),
        body: {
          "reqNo": widget.currentMember.reqNo,
          "name": widget.currentMember.username
        });
    var getTempodata = json.decode(getTempo.body);
    countEdit = int.parse(getTempodata[0]['countEdit']);

    print("get COUNT EDIT: $countEdit");

    // if (getTempo.statusCode == 200) {

    // } else {
    //   return false;
    // }
  }

  deletePaidLeave() async {
    var data = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/deleteLeave.php"),
        body: {"reqNo": widget.currentMember.reqNo});
    if (data.statusCode == 200) {
      print("process update");
      // return true;
      updateLeave();
    } else {
      return false;
    }
  }

  updateLeave() async {
    try {
      var data = await http.post(
          Uri.parse(
              "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getFullNameOther.php"),
          body: {"full_name": widget.currentMember.username});
      var jsonData = json.decode(data.body);
      if (jsonData is List && jsonData.isNotEmpty) {
        leaveUsed = int.parse(jsonData[0]['leave_used']);
        remainingLeave = int.parse(jsonData[0]['remaining_leave']);

        leave_used.text = leaveUsed.toString();
        remaining_leave.text = remainingLeave.toString();
      } else {
        print("No data or empty array returned from getFullNameOther.php.");
        // return;
      }
      if (data.statusCode == 200) {
        print("sukses get data cuti");
      }

      var getData = await http.post(
          Uri.parse(
              "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/getCountLeave.php"),
          body: {"name": widget.currentMember.username});
      var getJsondata = json.decode(getData.body);
      // if (getJsondata is List && getJsondata.isNotEmpty) {
      countStatus = int.parse(getJsondata[0]['countStatus']);
      initial = remainingLeave;

      if (countStatus >= 0) {
        leaveUsed = countStatus;
        initial = totalLeave - leaveUsed;
      } else {
        print("NO DATA COUNT");
      }
      if (getData.statusCode == 200) {
        print("sukses get count cuti");
      }

      await updateTable();
    } catch (e) {
      print("Error parsing JSON data: $e");
    }
  }

  updateTable() async {
    var update = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/admin/paid_leave/update_leave.php"),
        body: {
          'full_name': widget.currentMember.username,
          'leave_used': leaveUsed.toString(),
          'remaining_leave': initial.toString()
        });
    if (update.statusCode == 200) {
      print("update sukses");
    }
  }

  edit() async {
    final response = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/approvals/member/paid_leave/editSetUserApproval.php"),
        body: {
          "types_leave": typePaidLeave.text,
          "reason_leave": reasonPaidLeave.text,
          "name_of_pic": picPaidLeave.text,
          "phone_number": phonePaidLeave.text,
          "shift": shiftPaidLeave.text,
          "date_start_leave": startDatePaidLeave.text,
          "date_end_leave": endDatePaidLeave.text,
          "date_back_to_work": onDutyPaidLeave.text,
          "reqNo": widget.currentMember.reqNo
        });
    if (response.statusCode == 200) {
      print("process update");
      return true;
    } else {
      return false;
    }
  }

  List<String> typeLeave = [
    "Maternity leave ",
    "Permission leave",
    "Leave government call / Umrah"
  ];

  String selectedLeaveType = '';

  List<String> shiftLeave = [
    "Shift I",
    "Shift II",
    "Shift III",
  ];

  String selectedShiftLeave = '';

  MemberListPaidLeave? currentMember;

  @override
  void initState() {
    super.initState();
    request.getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 147, 195, 234),
              Color.fromARGB(255, 98, 171, 232),
              Color.fromARGB(255, 123, 185, 235),
            ]),
          ),
        ),
        elevation: 0,
        title: Text(
          "Paid Leave Application Form",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            Padding(
              // padding: const EdgeInsets.only(left: 30, right: 30, top: 160),
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              child: Container(
                width: 380,
                // height: 900,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 147, 195, 234),
                        blurRadius: 15,
                        offset: Offset(5, 5))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 30, bottom: 30),
                  child: Form(
                      key: formKeyss_,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_drop_down),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Please Complete This Form",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                          SizedBox(height: 50),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                readOnly: true,
                                autofocus: false,
                                decoration: InputDecoration(
                                    labelText: "Name",
                                    hintText: "",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                controller: namePaidLeave,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name here';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Position",
                                    hintText: "Please input your position here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                controller: positionPaidLeave,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your position here';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                readOnly: true,
                                autofocus: false,
                                controller: projectPaidLeave,
                                decoration: InputDecoration(
                                    labelText: "Project",
                                    hintText: "",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                // controller: projectLeaveController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your project here';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Department",
                                    hintText:
                                        "Please input your department here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                controller: departmentPaidLeave,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your department here';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: DropdownSearch<String>(
                                  popupProps: PopupProps.dialog(
                                    showSelectedItems: true,
                                    // disabledItemFn: (String s) => s.startsWith('I'),
                                  ),
                                  items: typeLeave,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedLeaveType = value as String;
                                      typePaidLeave.text = selectedLeaveType;
                                    });
                                  },
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: "Type of Leave",
                                        hintText: "Choose type of leave !",
                                        border: InputBorder.none),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your type of leave here';
                                    }
                                    return null;
                                  },
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Reason of Leave",
                                    hintText: "Please input your reason here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                controller: reasonPaidLeave,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your reason here';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Emergency Contact",
                                    hintText: "Please input your PIC here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                controller: picPaidLeave,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your PIC name here';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: IntlPhoneField(
                                controller: phonePaidLeave,
                                keyboardType: TextInputType.phone,
                                focusNode: FocusNode(),
                                dropdownTextStyle: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    labelText: "Handphone Number",
                                    hintText: "Please input your number here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                initialCountryCode: 'ID',
                                onChanged: (phone) {
                                  print(phone.completeNumber);
                                },
                                validator: (value) {
                                  if (value == null ||
                                      value.completeNumber.isEmpty) {
                                    return "Phone Nummber Can not empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: DropdownSearch<String>(
                                  popupProps: PopupProps.dialog(
                                    showSelectedItems: true,
                                    // disabledItemFn: (String s) => s.startsWith('I'),
                                  ),
                                  items: shiftLeave,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedShiftLeave = value as String;
                                      shiftPaidLeave.text = selectedShiftLeave;
                                    });
                                  },
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: "Your Shift",
                                        hintText: "Choose your shift !",
                                        border: InputBorder.none),
                                  ),
                                  // onChanged: print,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your shift here';
                                    }
                                    return null;
                                  },
                                ),
                              )),

                          SizedBox(height: 20),

                          //Date Start
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "Start Date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: "Date Leave",
                                            hintText:
                                                "Please enter your date leave",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            prefixIcon: Icon(
                                                Icons.calendar_today,
                                                color: Colors.grey)),
                                        readOnly: true,
                                        controller: startDatePaidLeave,
                                        onTap: () async {
                                          await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100))
                                              .then((selectedDate) {
                                            if (selectedDate != null) {
                                              startDatePaidLeave.text =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(selectedDate);
                                            }
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter the date !';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),

                              //Date Until
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "End Date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: "Date Leave",
                                            hintText:
                                                "Please enter your date leave",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            prefixIcon: Icon(
                                                Icons.calendar_today,
                                                color: Colors.grey)),
                                        readOnly: true,
                                        controller: endDatePaidLeave,
                                        onTap: () async {
                                          await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100))
                                              .then((selectedDate) {
                                            if (selectedDate != null) {
                                              endDatePaidLeave.text =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(selectedDate);
                                            }
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter the date !';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          //Date on Duty / Back to Work
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "On Duty",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Date on Duty",
                                      hintText:
                                          "Please enter the date of your assignment",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.calendar_today,
                                          color: Colors.grey)),
                                  readOnly: true,
                                  controller: onDutyPaidLeave,
                                  onTap: () async {
                                    await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100))
                                        .then((selectedDate) {
                                      if (selectedDate != null) {
                                        onDutyPaidLeave.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(selectedDate);
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter the date !';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 30,
                          ),

                          // BUTTON SUBMIT
                          FutureBuilder(
                            future: request.getLeaveNew(),
                            builder: (context, snapshot) {
                              return MaterialButton(
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 124, 185, 236),
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
                                  getTemporary();
                                  if (formKeyss_.currentState!.validate() ??
                                      false) {
                                    if (startDatePaidLeave.text.isNotEmpty &&
                                        endDatePaidLeave.text.isNotEmpty) {
                                      DateTime startDate =
                                          DateFormat('yyyy-MM-dd')
                                              .parse(startDatePaidLeave.text);
                                      DateTime endDate =
                                          DateFormat('yyyy-MM-dd')
                                              .parse(endDatePaidLeave.text);

                                      Duration difference =
                                          endDate.difference(startDate);
                                      if (difference.inDays + 1 >
                                          request.remainingLeave + countEdit) {
                                        print("gak bisa cuti");
                                        print(
                                            "total hari: ${difference.inDays + 1}");
                                        print(
                                            "sisah cuti: ${request.remainingLeave + countEdit}");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "You cannot take more leave than your remaining leave")));
                                      } else if (request.remainingLeave != 0) {
                                        print("bisa ajuin cuti");
                                        deletePaidLeave();
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Form Approved"),
                                                content: Text(
                                                    'The form has been submit !'),
                                                actions: <Widget>[
                                                  TextButton(
                                                      onPressed: () {
                                                        edit();
                                                        Navigator.of(context)
                                                            .pop();
                                                        MemberRequestPaidLeaveController()
                                                            .clearInfo();
                                                        Get.offAll(
                                                            ListPengajuanCuti());
                                                      },
                                                      child: Text("OK"))
                                                ],
                                              );
                                            });
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "You dont have any leave left")),
                                      );
                                      print(
                                          "total remaining leave: ${request.remainingLeave}");
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Form is not valid')),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
