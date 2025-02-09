import 'package:absent_project/MapsViews/MapsConfirmLocationPages/GmapsConfirmHeader2.dart';
import 'package:absent_project/MapsViews/MapsConfirmLocationPages/GmapsConfirmHeaders.dart';
import 'package:absent_project/MapsViews/MapsConfirmLocationPages/GmapsConfirmWrapper.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationPage.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/home/ApplicationBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class gmapsConfirmPages extends StatefulWidget {
  // const gmapsConfirmPages({super.key});
  final String imagePath;

  const gmapsConfirmPages({super.key, required this.imagePath});

  @override
  State<gmapsConfirmPages> createState() => _gmapsConfirmPagesState();
}

class _gmapsConfirmPagesState extends State<gmapsConfirmPages> {
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
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
            "CONFIRM CLOCK IN",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white
            ),
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     colors: [
            //       Color.fromARGB(255, 145, 201, 247),
            //       Color.fromARGB(255, 98, 171, 232),
            //       Color.fromARGB(255, 123, 185, 235),
            //       Color.fromARGB(255, 255, 255, 255),
            //     ],
            //   ),
            // ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 10),
                      child: gmapsConfirmHeaders(imagePath: widget.imagePath),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: gmapsConfirmField2(),
                    ),
                  ],
                ),
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
                      child: gmapsConfirmWrappers(),
                    ),
                  ),
                ),
              ],
            )
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
                Get.offAll(() => ApplicationBar());
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
