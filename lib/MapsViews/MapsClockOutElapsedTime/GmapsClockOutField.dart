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

  String dropDownValues = "";

  @override
  void initState() {
    super.initState();
    dropDownValues = "";
    streetLocation();
    projectLocation();
    userNameLocation();
    fullNameLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Form(
            child: Column(
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
                    controller: fullNamesLocationController,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      hintText: "Full Name",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person
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
                    controller: userNameLocationFieldController,
                    decoration: InputDecoration(
                        labelText: "User Name",
                        hintText: "User Name",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                            Icons.person
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
                    controller: projectLocationFieldController,
                    decoration: InputDecoration(
                        labelText: "Project",
                        hintText: "Project",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                            Icons.work
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
                            Icons.location_pin
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
                    decoration: InputDecoration(
                        labelText: "Shift",
                        hintText: "Shift",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                            Icons.work_history
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
                    decoration: InputDecoration(
                        labelText: "Notes",
                        hintText: "Notes",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                            Icons.note
                        )
                    ),
                  ),
                ),
              ],
            )
         )
       ],
    );
  }
}
