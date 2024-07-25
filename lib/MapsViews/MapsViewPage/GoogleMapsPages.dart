import 'package:absent_project/MapsViews/MapsViewPage/GoogleMapsWrapper.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/home/ApplicationBar.dart';
import 'package:absent_project/login/LoginPage.dart';
import 'package:absent_project/menu/MenuPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class googleMapsPages extends StatefulWidget {
  const googleMapsPages({super.key});

  @override
  State<googleMapsPages> createState() => _googleMapsPagesState();
}

class _googleMapsPagesState extends State<googleMapsPages> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldNavigateBack = (await _showConfirmDialog(context)) as bool;
        return shouldNavigateBack;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _showConfirmDialog(context);
            },
            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
          ),
          backgroundColor: Color.fromARGB(255, 98, 171, 232),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "SELECTED LOCATION",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: googleMapsWrapper()
      ),
    );
  }

  Future<Future<bool?>> _showConfirmDialog(BuildContext context) async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Icon(Icons.warning_amber,
                color: Colors.deepOrange),
            title: Text(
              "Attentions!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text("ARE YOU SURE WANT TO EXIT"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("NO",style:
                TextStyle(color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(onPressed: (){
                Get.offAll(() => ApplicationBar());
                ctr_data().clear_maps_func();
              },
                child:Text("YES",style:
                TextStyle(color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }
    );
  }
}
