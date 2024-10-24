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

Future<bool?> inRadiusValues() async {
  final latitudes = await findLatitudeOnly();
  final longtitudes = await findLongtitudeOnly();
  final radiusInMeters = await findRadiusLocation();


  final double latitudeLocations  = latitudes!;
  final double longtitudeLocations = longtitudes!;
  final double radiusOnMeters = radiusInMeters!;

  Position currentPositioneds = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
  );

  double distanceInMeters = Geolocator.distanceBetween(
      latitudeLocations,
      longtitudeLocations,
      currentPositioneds.latitude,
      currentPositioneds.longitude
  );
  return distanceInMeters <= radiusOnMeters;
}

/*String  getTodayDates() {
  return DateFormat('yyyy-MM-dd').format(DateTime.now());
}

Future<void> saveClockInDate() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String today = getTodayDates();
  await prefs.setString('lastClockInDate', today);
}

Future<bool> hasClockedInToday() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? lastClockInDate = prefs.getString('lastClockInDate');
  String today = getTodayDates();

  if (lastClockInDate == today) {
    return true;
  }
  return false;
}*/


class _gmapsLocationWrapperState extends State<gmapsLocationWrapper> {
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
        onPressed: () async{

          String? lastClockInValues = await findLastClockIn();
          bool? inRadius = await inRadiusValues();

          //if (lastClockInValues == null ){

            //if (inRadius!) {
              Get.offAll(CameraDetection());
            //} else {
             // locationNamesController.text = 'Invalid Radius Location';
            //}

          //} else{
            //final snackBar = SnackBar(
               // content: const Text("You Can Not Clockin Again In The Same Time!")
            //);
            //ScaffoldMessenger.of(context).showSnackBar(snackBar);
         // }

          //bool? hasClockedIn = await hasClockedInToday();
          //if (hasClockedIn) {
             //Get.snackbar('Error', 'You has been log in today');
             //return;
        // }

          //else {
            //Get.offAll(CameraDetection());
          //}

          //bool? inRadius = await inRadiusValues();
          //if(inRadius!) {
            //await saveClockInDate();
            //Get.offAll(CameraDetection());
          //} else {
            //locationNamesController.text = 'Invalid Radius Location';
          //}
        },
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
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}
