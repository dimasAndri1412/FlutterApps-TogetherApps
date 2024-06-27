import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:absent_project/approvalls/lembur/add_lembur_button.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeController.dart';
import 'package:absent_project/controller/Keys.dart';

class PengajuanLemburShifting extends StatefulWidget {
  const PengajuanLemburShifting({super.key});

  @override
  State<PengajuanLemburShifting> createState() => _PengajuanLemburState();
}

class _PengajuanLemburState extends State<PengajuanLemburShifting> {
  MemberRequestOvertimeController request = MemberRequestOvertimeController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Unique GlobalKey for Form

  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    // TODO: implement initState
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
        title: const Text(
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
                      const BoxShadow(
                          color: Color.fromARGB(255, 147, 195, 234),
                          blurRadius: 15,
                          offset: Offset(5, 5))
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 30, bottom: 30),
                    child: Form(
                      key: formKey, // Assign the GlobalKey to the Form
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_drop_down),
                              SizedBox(width: 5),
                              Text(
                                "Please Complete This Form",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                readOnly: true,
                                decoration: const InputDecoration(
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
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    labelText: "Position",
                                    hintText:
                                    "Please input your position here",
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
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    labelText: "Project",
                                    hintText:
                                    "Please input your project here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                controller: projectOTController,
                                readOnly: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your project here';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: const InputDecoration(
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
                          const SizedBox(height: 20),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
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
                                  dropdownDecoratorProps:
                                  DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: "Your Shift",
                                        hintText: "Choose your shift !",
                                        border: InputBorder.none),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      shiftOTController.text = value as String;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your shift here';
                                    }
                                    return null;
                                  },
                                ),
                              )),
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: const Text(
                                  "Start Date",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  decoration: const InputDecoration(
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
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 0),
                                      child: const Text(
                                        "Start Time",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      child: TextFormField(
                                        controller: timeStartOTController,
                                        readOnly: true,
                                        decoration: const InputDecoration(
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
                                              TimePickerEntryMode
                                                  .dial);
                                          if (timeOfDay != null) {
                                            setState(() {
                                              selectedTime = timeOfDay;
                                              timeStartOTController.text =
                                                  selectedTime
                                                      .format(context);
                                            });
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'Enter the Time !';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 0),
                                      child: const Text(
                                        "End Time",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      child: TextFormField(
                                        controller: timeEndOTController,
                                        readOnly: true,
                                        decoration: const InputDecoration(
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
                                              TimePickerEntryMode
                                                  .dial);
                                          if (timeOfDay != null) {
                                            setState(() {
                                              selectedTime = timeOfDay;
                                              timeEndOTController.text =
                                                  selectedTime
                                                      .format(context);
                                            });
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
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
                          const SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    labelText: "Activity",
                                    hintText:
                                    "Please input your activity here",
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
                          const SizedBox(height: 20),
                          const SizedBox(height: 30),
                          const addLemburButton(),
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
