import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationField.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationView.dart';
import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/attendance/CameraDetection.dart' ;
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class gmapsLocationWrapper extends StatefulWidget {
  const gmapsLocationWrapper({super.key});

  @override
  State<gmapsLocationWrapper> createState() => _gmapsLocationWrapperState();
}

class _gmapsLocationWrapperState extends State<gmapsLocationWrapper> {

  bool isInRadius = false;

  Future<bool> validateRadiusValues() async {
    try {
      List<double?> latitudeValues = await revampFindLatitudesOnly();
      List<double?> longtitudeValues = await revampFindLongtitudeOnly();
      List<double?> radiusValues = await revampFindRadiusOnly();
      //List<String?> locationNamesValues = await revampFindLocationsNamesNews();

      if (latitudeValues.length != longtitudeValues.length || latitudeValues.length != radiusValues.length) {
          print("Data inconsistency detected! Trimming data to match lengths.");
      }

      Position currentPositioned = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      for (int i = 0; i < latitudeValues.length; i++) {
        double? latitude = latitudeValues[i];
        double? longtitude = longtitudeValues[i];
        double? radius = radiusValues[i];
        //String? name = locationNamesValues[i];

        if (latitude != null && longtitude != null && radius != null) {
          double distanceInMeters = Geolocator.distanceBetween(
            latitude,
            longtitude,
            currentPositioned.latitude,
            currentPositioned.longitude,
          );

          if (distanceInMeters <= radius) {
            //locationNamesController.text = "Your Position Is Out of Radius Now!!!";
            return true;
          }
        }
      }
    } catch (errs) {
      print("Error in validateRadiusValues: $errs");
    }
    return false;
  }

  Future<void> checkingInRadius() async {
    bool inRadius = await validateRadiusValues();
     setState(() {
       isInRadius = inRadius;
     });
  }

  @override
  void initState() {
    checkingInRadius();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: GmapsViews(),
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Container(
              height: 145,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 30),
                    blurRadius: 80,
                    color: Colors.black26,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: gmapsLocationFields(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: isInRadius ? () async{
           bool inRadius = await validateRadiusValues();
           String? lastClockINValues = await findLastClockIn();

           if (lastClockINValues == null) {
             if(inRadius) {
               Get.offAll(CameraDetection());
             } else {
               locationNamesController.text = "Your Position Is Out of Radius Now!!!";
             }
           } else {
             final snackBars = SnackBar(content: const Text("You Can Not Clockin Again In The Same Time!"));
             ScaffoldMessenger.of(context).showSnackBar(snackBars);
           }

        } : null,
        label: Text(
          "Start",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        icon: Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
        backgroundColor: isInRadius ? Colors.lightBlueAccent : Colors.grey,
      ),
    );
  }
}
