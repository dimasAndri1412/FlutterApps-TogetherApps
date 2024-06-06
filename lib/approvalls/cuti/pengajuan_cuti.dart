import 'dart:convert';
import 'package:http/http.dart' as http;



import 'package:absent_project/approvalls/cuti/add_cuti_button.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeave.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';

class PengajuanCuti extends StatefulWidget {
  const PengajuanCuti({super.key});

  @override
  State<PengajuanCuti> createState() => _PengajuanCutiState();
}

class _PengajuanCutiState extends State<PengajuanCuti> {
  final MemberRequestPaidLeaveController request = MemberRequestPaidLeaveController();

  List<String> typeLeave = [
    "Maternity leave ",
    "Sick leave",
    "Permission leave",
    "Leave late coming / leaving early",
    "Leave government call / Umrah"
  ];

  String selectedLeaveType = '';

  List<String> shiftLeave = [
    "Shift I",
    "Shift II",
    "Shift III",
  ];

  String selectedShiftLeave = '';

  @override
  void initState(){
    super.initState();
    request.getUsers();
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
                                    labelText: "Name of PIC",
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
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Handphone Number",
                                    hintText: "Please input your number here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                controller: phonePaidLeave,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number here';
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

                          //BUTTON SUBMIT
                          addCutiButton(),
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
