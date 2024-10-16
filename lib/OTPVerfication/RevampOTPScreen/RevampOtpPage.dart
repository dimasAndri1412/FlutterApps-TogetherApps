import 'package:absent_project/OTPVerfication/OTPVerficationPage.dart';
import 'package:absent_project/OTPVerfication/RevampOTPScreen/RevampOtpFields.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

class revampOTPPages extends StatefulWidget {
  const revampOTPPages({super.key});

  @override
  State<revampOTPPages> createState() => _revampOTPPagesState();
}

class _revampOTPPagesState extends State<revampOTPPages> {
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
            "VERIFICATION OTP",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: revampOTPField()
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
                child: Text("NO", style:
                TextStyle(color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(onPressed: () {
                Get.offAll(() => OTPVerficationPage());
                ctr_data().clear_func();
              },
                child: Text("YES", style:
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
