import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/MapsViews/MatterialMaps/GmapsStopWatchController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class gmapsElapsedTimesField extends StatefulWidget {
  const gmapsElapsedTimesField({super.key});

  @override
  State<gmapsElapsedTimesField> createState() => _gmapsElapsedTimesFieldState();
}


class _gmapsElapsedTimesFieldState extends State<gmapsElapsedTimesField> {

  final stopWatchControll = Get.put(gmapsStopWatchController());

  void streetAndNameLocation() async {
    final findlocationAndStreet = await findLocationNames();
    locationNamesController.text = findlocationAndStreet!;
  }

  @override
  void initState() {
    super.initState();
    streetAndNameLocation();
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
                    controller: elapsedTimesController.value,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Elapsed Times",
                        hintText: "00:00:00",
                        hintStyle: TextStyle(
                            color: Colors.black26
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.timer,
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