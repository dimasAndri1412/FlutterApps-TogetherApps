import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GmapsElapsedTimePages.dart';
import 'package:absent_project/MapsViews/MapsClockOutElapsedTime/GmapsClockOutHeaders.dart';
import 'package:absent_project/MapsViews/MapsClockOutElapsedTime/GmapsClockUpWrapper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class gmapsClockOutPages extends StatefulWidget {
  const gmapsClockOutPages({super.key});

  @override
  State<gmapsClockOutPages> createState() => _gmapsClockOutPagesState();
}

class _gmapsClockOutPagesState extends State<gmapsClockOutPages> {
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
            "CONFIRM CLOCK OUT",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 145, 201, 247),
                Color.fromARGB(255, 98, 171, 232),
                Color.fromARGB(255, 123, 185, 235),
                Color.fromARGB(255, 255, 255, 255),
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              gmapsClockOutHeader(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: gmapsClockOutWrapper(),
                  ),
                ),
              ),
            ],
          ),
        ),
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
                Get.offAll(() => gmapsElapsedTimesPages());
                //ctr_data().clear_func();
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
