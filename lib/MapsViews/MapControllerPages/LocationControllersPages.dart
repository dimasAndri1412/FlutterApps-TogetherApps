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
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
                  _showConfirmDialog(context);
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
        )
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
                Get.offAll(() => listLocationsMaps());
                //ctr_data().clear_maps_func();
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
