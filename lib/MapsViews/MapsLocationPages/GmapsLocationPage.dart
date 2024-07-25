import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationWrapper.dart';
import 'package:absent_project/home/ApplicationBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class gmapsLocationPages extends StatefulWidget {
  const gmapsLocationPages({super.key});

  @override
  State<gmapsLocationPages> createState() => _gmapsLocationPagesState();
}

class _gmapsLocationPagesState extends State<gmapsLocationPages> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldNavigateBack = (await _showConfirmDialog(context)) as bool;
        return shouldNavigateBack;
      },
      child: Scaffold(
          body: gmapsLocationWrapper()
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
