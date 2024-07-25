import 'dart:async';
import 'package:absent_project/MapsViews/MapsConfirmLocationPages/GmapsConfirmPages.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class gmapsLocationButton extends StatefulWidget {
  const gmapsLocationButton({super.key});

  @override
  State<gmapsLocationButton> createState() => _gmapsLocationButtonState();
}

class _gmapsLocationButtonState extends State<gmapsLocationButton> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        children: <Widget>[
          FloatingActionButton.extended(
            onPressed: () {
              Get.offAll(() => gmapsConfirmPages());
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
        ],
      ),
    );
  }
}
