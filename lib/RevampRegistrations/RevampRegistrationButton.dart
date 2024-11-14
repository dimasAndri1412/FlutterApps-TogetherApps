import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/data_controller.dart';
import 'package:absent_project/controller/sendingEmailfunc.dart';
import 'package:absent_project/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class revampRegistrationButtons extends StatefulWidget {
  const revampRegistrationButtons({super.key});

  @override
  State<revampRegistrationButtons> createState() => _revampRegistrationButtonsState();
}

class _revampRegistrationButtonsState extends State<revampRegistrationButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
            onTap: (){
              if (revampRegistrationsKey.currentState!.validate()){
                ctr_data().revampSaveFunc().then((value) {
                  if (value) {
                    const snackBar = SnackBar(
                      content: Text('Data Berhasil Disimpan'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    sendingEmail().sendingEmailFunc();
                    ctr_data().revamp_clear_func();
                    Get.offAll(() => LoginPage());
                  } else {
                    const snackBar = SnackBar(
                      content: const Text('Data Gagal Disimpan'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });

                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => testPagesNew()));
              }
            },
            child: Container(
                height: 60,
                width: 300,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                )
            ),
        )
      ],
    );
  }
}
