import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';

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
            key: gmapsConfirmKey,
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
                    controller: fullNamesLocationController,
                    decoration: InputDecoration(
                        labelText: "FullNames",
                        hintText: "FullNames",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person,
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
                    controller: userNameLocationFieldController,
                    decoration: InputDecoration(
                      labelText: "UserNames",
                      hintText: "UserNames",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person,
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
                          if (value.isNotEmpty) {
                            shiftLOcationFieldController.text = value;
                          } else {
                            shiftLOcationFieldController.clear();
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
                    controller: shiftLOcationFieldController,
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
                    controller: noteLocationController,
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
      ],
    );
  }
}
