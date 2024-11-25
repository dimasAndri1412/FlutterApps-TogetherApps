import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/controller/insertAddressLocations.dart';
import 'package:absent_project/home/ApplicationBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class googleMapsButtons extends StatefulWidget {
  const googleMapsButtons({super.key});

  @override
  State<googleMapsButtons> createState() => _googleMapsButtonsState();
}

class _googleMapsButtonsState extends State<googleMapsButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            if (GoogleMapsForm.currentState!.validate()) {

              String? verifyLocationNames = await findVerifyLocationName();

              if (verifyLocationNames == null || verifyLocationNames.isEmpty) {
                insertAddressLocationController().insertToLocationAddress();
                final snackBar = SnackBar(content: Text("Location Save Successfully"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                ctr_data().clear_maps_func();
                Get.offAll(() => ApplicationBar());

              } else {
                final snackBar = SnackBar(content: Text("Location is Already Exsist"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else {
              final snackBar = SnackBar(content: Text("Location Can not save"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              ctr_data().clear_maps_func();
            }
          },
          child: Container(
              height: 50,
              width: 300,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'SAVE LOCATION',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),

                ),
              )
          ),
        )
      ],
    );
  }
}
