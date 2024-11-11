import 'package:absent_project/MapsViews/MapControllerPages/locationSettingPages.dart';
import 'package:absent_project/MapsViews/MapsInformationPages/ListLocationMapsPages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class locationsControllersPages extends StatefulWidget {
  const locationsControllersPages({super.key});

  @override
  State<locationsControllersPages> createState() => _locationsControllersPagesState();
}

class _locationsControllersPagesState extends State<locationsControllersPages> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LOCATION SETTING",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          onPressed: () {
            Get.offAll(listLocationsMaps());
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: locationSettingPages()
          ),
        ],
      )
    );
  }
}
