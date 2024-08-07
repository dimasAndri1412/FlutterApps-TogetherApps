import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:absent_project/approvalls/lembur/user/add_lembur_button.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeController.dart';
import 'package:absent_project/controller/Keys.dart';

class PengajuanLembur extends StatefulWidget {
  const PengajuanLembur({super.key});

  @override
  State<PengajuanLembur> createState() => _PengajuanLemburState();
}

class _PengajuanLemburState extends State<PengajuanLembur> {
  MemberRequestOvertimeController request = MemberRequestOvertimeController();
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // Unique GlobalKey for Form

  TimeOfDay selectedTime = TimeOfDay.now();

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
          "Overtime Application Form",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: Container(
                  width: 380,
                  // height: 370,
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
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 30, bottom: 30),
                    child: Form(
                      key: formOTKey, // Assign the GlobalKey to the Form
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_drop_down),
                              SizedBox(width: 5),
                              Text(
                                "Please Complete This Form",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(width: 5),
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
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    labelText: "Name",
                                    hintText: "Please input you name here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                controller: nameOTController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name here';
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
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Position",
                                    hintText: "Please input your position here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                controller: positionOTController,
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
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Project",
                                    hintText: "Please input your project here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                controller: projectOTController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your project here';
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
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Department",
                                    hintText:
                                        "Please input your department here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                controller: departmentOTController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your department here';
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
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Location",
                                    hintText: "Please input your location here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                // controller: departmentOTController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your location here';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "Start Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Date Overtime",
                                      hintText:
                                          "Please enter the date overtime",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.calendar_today,
                                          color: Colors.grey)),
                                  readOnly: true,
                                  controller: dateOTController,
                                  onTap: () async {
                                    await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100))
                                        .then((selectedDate) {
                                      if (selectedDate != null) {
                                        dateOTController.text =
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
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "Start Time",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        controller: timeStartOTController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            prefixIcon: Icon(
                                                Icons.access_time_rounded,
                                                color: Colors.grey)),
                                        onTap: () async {
                                          final TimeOfDay? timeOfDay =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: selectedTime,
                                                  initialEntryMode:
                                                      TimePickerEntryMode.dial);
                                          if (timeOfDay != null) {
                                            setState(() {
                                              selectedTime = timeOfDay;
                                              timeStartOTController.text =
                                                  selectedTime.format(context);
                                            });
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter the Time !';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "End Time",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: TextFormField(
                                        controller: timeEndOTController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            prefixIcon: Icon(
                                                Icons.access_time_rounded,
                                                color: Colors.grey)),
                                        onTap: () async {
                                          final TimeOfDay? timeOfDay =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: selectedTime,
                                                  initialEntryMode:
                                                      TimePickerEntryMode.dial);
                                          if (timeOfDay != null) {
                                            setState(() {
                                              selectedTime = timeOfDay;
                                              timeEndOTController.text =
                                                  selectedTime.format(context);
                                            });
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter the time !';
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
                          SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Activity",
                                    hintText: "Please input your activity here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                controller: activityOTController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your activity here';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(height: 30),
                          addLemburButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*
void main() {
  runApp(MaterialApp(
    home: PengajuanLembur(),
  ));
}*/
