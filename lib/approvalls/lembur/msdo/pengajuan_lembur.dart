import 'package:absent_project/controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertmaControlleri.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeGetListModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:absent_project/approvalls/lembur/msdo/add_lembur_button.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeController.dart';
import 'package:absent_project/controller/Keys.dart';

import '../../../controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertimeModel.dart';

class PengajuanLembur extends StatefulWidget {
  const PengajuanLembur({super.key});

  @override
  State<PengajuanLembur> createState() => _PengajuanLemburState();
}

class _PengajuanLemburState extends State<PengajuanLembur> {
  final AdminApprovalOvertimaController overtimeController =
      AdminApprovalOvertimaController();
  List<AdminApprovalOvertimeModel> nameList = [];
  AdminApprovalOvertimeModel? selectedName;

  AdminApprovalOvertimaController request = AdminApprovalOvertimaController();
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // Unique GlobalKey for Form

  TimeOfDay selectedTime = TimeOfDay.now();

  List<String> shiftLeave = [
    "Shift I",
    "Shift II",
    "Shift III",
  ];

  String selectedShiftLeave = '';
  String? selectedLocation;

  @override
  void initState() {
    super.initState();
    // request.getInfo();
    fetchNames();
  }

  Future<void> fetchNames() async {
    List<AdminApprovalOvertimeModel>? fetchedNames =
        await overtimeController.getAllName();
    if (fetchedNames != null) {
      setState(() {
        nameList = fetchedNames;
      });
      print('Data fetched: ${nameList.length} items'); // Debug line
    } else {
      print('No data fetched or empty list'); // Debug line
    }
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
                          DropdownButtonFormField<AdminApprovalOvertimeModel>(
                            decoration: InputDecoration(
                                labelText: "Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            hint: Text("Please select name"),
                            items: nameList.map((name) {
                              return DropdownMenuItem(
                                value: name,
                                child: Text(name.full_name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              print("Dropdown changed: $value");
                              setState(() {
                                selectedName = value;

                                if (selectedName != null) {
                                  nameOTController.text =
                                      selectedName!.full_name;
                                  positionOTController.text =
                                      selectedName!.position;
                                  projectOTController.text =
                                      selectedName!.project;
                                  departmentOTController.text =
                                      selectedName!.department;
                                  if (selectedName!.location.isNotEmpty) {
                                    locationList = selectedName!.location;
                                    selectedLocation =
                                        null; // Reset pilihan lokasi
                                  } else {
                                    locationList = [];
                                  }
                                  print(
                                      "Location List: $locationList"); // Debug
                                } else {
                                  nameOTController.clear();
                                  projectController.clear();
                                }
                              });
                              print(
                                  'Selected Name: ${selectedName?.full_name}');
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select name';
                              }
                              return null;
                            },
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
                                readOnly: true,
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
                                readOnly: true,
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
                                readOnly: true,
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
                          // Container(
                          //   decoration: BoxDecoration(
                          //       border:
                          //           Border.all(color: Colors.grey, width: 1),
                          //       borderRadius: BorderRadius.circular(12)),
                          //   child: Padding(
                          //     padding: EdgeInsets.only(left: 10),
                          //     child: TextFormField(
                          //       decoration: InputDecoration(
                          //           labelText: "Location",
                          //           hintText: "Please input your location here",
                          //           hintStyle: TextStyle(color: Colors.grey),
                          //           border: InputBorder.none),
                          //       controller: locationOTController,
                          //       validator: (value) {
                          //         if (value == null || value.isEmpty) {
                          //           return 'Please enter your location here';
                          //         }
                          //         return null;
                          //       },
                          //     ),
                          //   ),
                          // ),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                labelText: "Location",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            hint: Text("Please select location"),
                            items: locationList.map((location) {
                              return DropdownMenuItem(
                                value: location,
                                child: Text(location),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedLocation = value;
                                locationOTController.text = selectedLocation!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select location';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
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
                                      shiftOTController.text =
                                          selectedShiftLeave;
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
                                            labelText: "Start Overtime",
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
                                            labelText: "End Overtime",
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
