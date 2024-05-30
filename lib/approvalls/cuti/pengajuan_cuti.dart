// import 'dart:io';

import 'package:absent_project/approvalls/cuti/add_cuti_button.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path/path.dart';
import 'package:dropdown_search/dropdown_search.dart';

class PengajuanCuti extends StatefulWidget {
  const PengajuanCuti({super.key});

  @override
  State<PengajuanCuti> createState() => _PengajuanCutiState();
}

class _PengajuanCutiState extends State<PengajuanCuti> {
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final departmentController = TextEditingController();
  // final typeLeaveController = TextEditingController();
  final reasonCutiController = TextEditingController();
  final namePICController = TextEditingController();
  final handphoneNumberController = TextEditingController();
  final _dateFromController = TextEditingController();
  final _dateUntilController = TextEditingController();
  final _dateDutyController = TextEditingController();

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
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 30, bottom: 50),
              child: Container(
                width: 390,
                height: 900,
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
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: Form(
                      child: Column(
                    children: [
                      // SizedBox(height: 50),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Name",
                              hintText: "Please input your name here",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your reason here';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Position",
                              hintText: "Please input your position here",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          controller: positionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your reason here';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Department",
                              hintText: "Please input your department here",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          controller: departmentController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your reason here';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black))),
                          child: DropdownSearch<String>(
                            popupProps: PopupProps.dialog(
                              showSelectedItems: true,
                              // disabledItemFn: (String s) => s.startsWith('I'),
                            ),
                            items: [
                              "Maternity leave ",
                              "Sick leave",
                              "Permission leave",
                              "Leave late coming / leaving early",
                              "Leave government call / Umrah",
                            ],
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Type of Leave",
                                hintText: "Choose type of leave !",
                              ),
                            ),
                            // onChanged: print,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your reason here';
                              }
                              return null;
                            },
                          )),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Reason of Leave",
                              hintText: "Please input your reason here",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          controller: reasonCutiController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your reason here';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Name of PIC",
                              hintText: "Please input your PIC here",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          controller: namePICController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your reason here';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Handphone Number",
                              hintText: "Please input your number here",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          controller: handphoneNumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your reason here';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black))),
                          child: DropdownSearch<String>(
                            popupProps: PopupProps.dialog(
                              showSelectedItems: true,
                              // disabledItemFn: (String s) => s.startsWith('I'),
                            ),
                            items: [
                              "Shift I",
                              "Shift II",
                              "Shift III",
                            ],
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Your Shift",
                                hintText: "Choose your shift !",
                              ),
                            ),
                            // onChanged: print,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your reason here';
                              }
                              return null;
                            },
                          )),

                      SizedBox(height: 20),

                      //Date Start
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Start from :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Date Leave",
                              hintText: "Please enter your date leave",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.calendar_today)),
                          readOnly: true,
                          controller: _dateFromController,
                          onTap: () async {
                            await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100))
                                .then((selectedDate) {
                              if (selectedDate != null) {
                                _dateFromController.text =
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
                      SizedBox(
                        height: 20,
                      ),

                      //Date Until
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Until :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Date Leave",
                              hintText: "Please enter your date leave",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.calendar_today)),
                          readOnly: true,
                          controller: _dateUntilController,
                          onTap: () async {
                            await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100))
                                .then((selectedDate) {
                              if (selectedDate != null) {
                                _dateUntilController.text =
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
                      SizedBox(
                        height: 50,
                      ),

                      //Date on Duty / Back to Work
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Back to work :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Date on Duty",
                              hintText:
                                  "Please enter the date of your assignment",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.calendar_today)),
                          readOnly: true,
                          controller: _dateDutyController,
                          onTap: () async {
                            await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100))
                                .then((selectedDate) {
                              if (selectedDate != null) {
                                _dateDutyController.text =
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
