import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/AbsentController/ClockInController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';


class gmapsClockOutHeaders2 extends StatefulWidget {
  const gmapsClockOutHeaders2({super.key});

  @override
  State<gmapsClockOutHeaders2> createState() => _gmapsClockOutHeaders2State();
}

class _gmapsClockOutHeaders2State extends State<gmapsClockOutHeaders2> {

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
  late ClockInController controller;
  Future<String>? userName;

  @override
  void initState() {
    super.initState();
    controller = ClockInController();
    userName = controller.fetchUserName();
    dropDownValues = "";
    streetLocation();
    projectLocation();
    userNameLocation();
    fullNameLocation();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: userName,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(snapshot.data ?? "Unknown User",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text("Via IOS 17",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey
                  ),
                ),
                Text("Iphone 11",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey
                  ),
                ),
                Text("Active Now",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
