import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class gmapsLocationFields extends StatefulWidget {
  const gmapsLocationFields({super.key});

  @override
  State<gmapsLocationFields> createState() => _gmapsLocationFieldsState();
}

class _gmapsLocationFieldsState extends State<gmapsLocationFields> {

  void  locationNamesValues() async {
    final findlocations = await findLocationNames();
    locationNamesController.text = findlocations!;
  }

  void streetAndNameLocation() async {
    final findlocationAndStreet = await findLocationNames();
    locationNamesController.text = findlocationAndStreet!;
  }

  void lastLogin() async {
    final findLastLoginss = await findLastLogIns();
    historyController.text = findLastLoginss!;
  }

  @override
  void initState() {
    super.initState();
    streetAndNameLocation();
    lastLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    controller: historyController,
                    decoration: InputDecoration(
                        labelText: "History Absent",
                        hintText: "History Absent",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.history,
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
                            color: Colors.transparent
                        ),
                      )
                  ),
                  child: TextFormField(
                    controller: locationNamesController,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Location",
                        hintText: "Location",
                        hintStyle: TextStyle(
                            color: Colors.black26
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.location_pin,
                          color: Colors.black26,
                        )
                    ),
                  ),
                )
              ],
            )
        )
      ],
    );
  }
}