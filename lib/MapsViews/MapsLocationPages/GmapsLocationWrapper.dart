import 'package:absent_project/MapsViews/MapsConfirmLocationPages/GmapsConfirmPages.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationButton.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationField.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationPage.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationView.dart';
import 'package:absent_project/attendance/Camera.dart';
import 'package:absent_project/attendance/CameraDetection.dart' ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';




class gmapsLocationWrapper extends StatefulWidget {
  const gmapsLocationWrapper({super.key});

  @override
  State<gmapsLocationWrapper> createState() => _gmapsLocationWrapperState();
}

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
        onPressed: () {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CameraDetection()),
          );
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
