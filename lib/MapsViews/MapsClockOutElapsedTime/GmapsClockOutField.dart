import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';


class gmapsClockOutField extends StatefulWidget {
  const gmapsClockOutField({super.key});

  @override
  State<gmapsClockOutField> createState() => _gmapsClockOutFieldState();
}

class _gmapsClockOutFieldState extends State<gmapsClockOutField> {

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

  void ClockIinTimes() async {
    final findClockInTimesValues = await findClockInTimes();
    clockInController.text = findClockInTimesValues!;
  }

  void shiftClockIns() async {
    final findShiftClockInValues = await findShiftClockIn();
    shiftClockOutController.text = findShiftClockInValues!;
  }

  String dropDownValues = "";

  @override
  void initState() {
    super.initState();
    dropDownValues = "";
    streetLocation();
    projectLocation();
    userNameLocation();
    fullNameLocation();
    shiftClockIns();
    ClockIinTimes();
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
              readOnly: true,
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
              readOnly: true,
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
                  key: gmapsClockConfirmKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          readOnly: true,
                          controller: userNameLocationFieldController,
                          decoration: InputDecoration(
                              labelText: "User Names",
                              hintText: "User Names",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                  Icons.person
                              )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'User name can not empty!';
                            }
                          },
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
                          readOnly: true,
                          controller: clockInController,
                          decoration: InputDecoration(
                              labelText: "Clock In",
                              hintText: "Clock In",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                  Icons.lock_clock
                              )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Clock In can not empty!';
                            }
                          },
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
                          readOnly: true,
                          controller: elapsedTimesController.value,
                          decoration: InputDecoration(
                              labelText: "Elapsed Times",
                              hintText: "Elapsed Times",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                  Icons.lock_clock
                              )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Elapsed Times can not empty!';
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
                          readOnly: true,
                          controller: shiftClockOutController,
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
                              return 'Shift can not empty!';
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
                          controller: notesClockOut,
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
