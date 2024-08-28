import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:absent_project/controller/AbsentController/ClockInController.dart';


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
  late  String formattedDate;
  late ClockInController controller;
  String _project = "Loading...";

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(now);
    controller = ClockInController();
    _fetchProject();
    // findLocation();
    dropDownValues = "";
    // streetLocation();
    // projectLocation();
    // userNameLocation();
    // fullNameLocation();
  }

  Future<void> _fetchProject() async {
    try {
      String project = await controller.fetchProject();
      setState(() {
        _project = project;
        findLocation();
      });
      print(_project);
    } catch (e) {
      setState(() {
        _project = "Unknown Project";
        findLocation();
      });
      print('Error fetching user name: $e');
    }
  }

  void findLocation() {
    setState(() {
      if (_project == 'Dev Project' || _project == 'Development Project') {
        locationClockOut.text = 'Intiland';
      } else if (_project == 'MSDO Project'){
        locationClockOut.text = 'BRI Center Park';
      }
    });
    print(locationClockOut.text);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.login, 
                      color: Colors.grey[400],
                    ),
                    SizedBox(width: 20,),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.grey[400]
                      ),  
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Divider(),
                SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 20,),
                    Text(locationClockOut.text)
                  ],
                ),// 
                SizedBox(height: 5,),
                Divider(),
                SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.work),
                    SizedBox(width: 20,),
                    Text(_project)
                  ],
                ),
                SizedBox(height: 5,),
                Divider(),
              ],
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
