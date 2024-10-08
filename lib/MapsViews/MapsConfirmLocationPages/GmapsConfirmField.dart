import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/AbsentController/ClockInController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class gmapsConfirmField extends StatefulWidget {
  const gmapsConfirmField({super.key});

  @override
  State<gmapsConfirmField> createState() => _gmapsConfirmFieldState();
}

class _gmapsConfirmFieldState extends State<gmapsConfirmField> {

  void streetLocation() async {
    final findLocationStreet = await findLocationNames();
    locationFieldController.text = findLocationStreet!;
  }

  void projectLocation() async {
    final findProjectLocation = await findProjectss();
    projectLocationFieldController.text = findProjectLocation!;
  }

  void userNameLocation() async {
    final findUserNameLocationss = await findUserNameLocation();
    userNameLocationFieldController.text = findUserNameLocationss!;
  }

  void fullNameLocation() async {
    final findFullNamess = await findFullNameLocation();
    fullNamesLocationController.text = findFullNamess!;
  }

  String dropDownValues = "";
  late  String formattedDate;
  late ClockInController controller;
  //String _project = "Loading...";

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(now);
    controller = ClockInController();
    dropDownValues = "";
    streetLocation();
    projectLocation();
    userNameLocation();
    fullNameLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black26,
                        width: 2
                    )
                )
            ),
            child: TextFormField(
              controller: projectLocationFieldController,
              decoration: InputDecoration(
                  labelText: "Project",
                  hintText: "Project",
                  hintStyle: TextStyle(
                    color: Colors.black26,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.work,
                    color: Colors.black26,
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black26,
                        width: 2
                    )
                )
            ),
            child: TextFormField(
              controller: locationFieldController,
              decoration: InputDecoration(
                  labelText: "Location",
                  hintText: "Location",
                  hintStyle: TextStyle(
                    color: Colors.black26,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.location_pin,
                    color: Colors.black26,
                  )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(
              "Please insert your shift : ",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)
              ),
              child: Form(
                  key: gmapsConfirmKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black26,
                                    width: 2
                                )
                            )
                        ),
                        child: TextFormField(
                          readOnly: true,
                          controller: userNameLocationFieldController,
                          decoration: InputDecoration(
                              labelText: "User Name",
                              hintText: "User Name",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.note,
                                color: Colors.black26,
                              )
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border:
                              Border(bottom: BorderSide(color: Colors.black87))),
                          child: DropdownButtonFormField<String>(
                            value: dropDownValues,
                            items: [
                              DropdownMenuItem(
                                  child: Text(
                                    "--Selected Shift--",
                                    style: TextStyle(color: Colors.black26),
                                  ),
                                  value: ""),
                              DropdownMenuItem(
                                child: Text("SHIFT 1"),
                                value: "SHIFT 1",
                              ),
                              DropdownMenuItem(
                                child: Text("SHIFT 2"),
                                value: "SHIFT 2",
                              ),
                              DropdownMenuItem(
                                child: Text("SHIFT 3"),
                                value: "SHIFT 3",
                              ),
                              DropdownMenuItem(
                                child: Text("NON SHIFT"),
                                value: "NON SHIFT",
                              ),
                            ],
                            decoration: InputDecoration(
                                border: InputBorder.none, prefixIcon: Icon(Icons.work)),
                            onChanged: (value) {
                              setState(() {
                                dropDownValues = value!;
                                shiftController.text = value;
                                if (value.isNotEmpty) {
                                  shiftLocationFieldController.text = value;
                                } else {
                                  shiftLocationFieldController.clear();
                                }
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Select Project";
                              }
                              return null;
                            },
                          )
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black26,
                                    width: 2
                                )
                            )
                        ),
                        child: TextFormField(
                          controller: shiftLocationFieldController,
                          decoration: InputDecoration(
                              labelText: "SHIFT",
                              hintText: "SHIFT",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.timer_outlined,
                                color: Colors.black26,
                              )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Selected Shift";
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black26,
                                    width: 2
                                )
                            )
                        ),
                        child: TextFormField(
                          controller: notesClockIn,
                          decoration: InputDecoration(
                              labelText: "Notes",
                              hintText: "Notes",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.note,
                                color: Colors.black26,
                              )
                          ),
                        ),
                      ),
                    ],
                  )
              )
          )
        ],
      ),
    );
  }
}
