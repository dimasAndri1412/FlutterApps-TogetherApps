import 'package:absent_project/approvalls/sakit/user/ListPengajuanSakit.dart';
import 'package:absent_project/controller/AbsentController/ClockInController.dart';
import 'package:absent_project/controller/ApprovalController/SickLeaveController/Member/MemberSickLeaveController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FormPengajuanSakit extends StatefulWidget {
  const FormPengajuanSakit({super.key});

  @override
  State<FormPengajuanSakit> createState() => _FormPengajuanSakitState();
}

class _FormPengajuanSakitState extends State<FormPengajuanSakit> {
  final ClockInController _controller = ClockInController();
  String? userName; 
  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    try {
      String fetchedName = await _controller.fetchUserName();
      setState(() {
        userName = fetchedName;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        userName = "Failed to load name";
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dateSickLeaveController.clear();
    noteSickLeaveController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Get.to(ApplicationBarUser(
        //         initialIndex: 3,
        //       ));
        //     },
        //     icon: Icon(
        //       Icons.arrow_back_ios_sharp,
        //       color: Colors.white,
        //     )),
        title:Text(
            "Sick Leave Form",
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        // automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 147, 195, 234),
              Color.fromARGB(255, 98, 171, 232),
              Color.fromARGB(255, 123, 185, 235),
            ]),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 450,
          margin: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 0.5, color: Colors.grey),
          ),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Form(
              key: sickLeaveKey,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Insert Sick Leave Form",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ),
                  SizedBox(height: 40 ,),
                  isLoading
                    ? CircularProgressIndicator() 
                    :Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextFormField(
                          initialValue: userName,
                          readOnly: true,
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Name",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please insert the detail';
                            }
                            return null;
                          },
                        ),
                      ),
                    )
                  ),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                      color: Colors.grey, width: 1),
                      borderRadius:
                          BorderRadius.circular(8)
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Date Leave",
                          hintText:
                              "Please enter your date leave",
                          hintStyle:
                              TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                              Icons.calendar_today,
                              color: Colors.grey)),
                      readOnly: true,
                      controller: dateSickLeaveController,
                      onTap: () async {
                        DateTime now = DateTime.now();
                        DateTime today = DateTime(now.year, now.month, now.day);    
                        await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: today,
                                lastDate: DateTime(2100))
                            .then((selectedDate) {
                          if (selectedDate != null) {
                            dateSickLeaveController.text =
                                DateFormat('yyyy-MM-dd')
                                    .format(selectedDate);
                          }
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the date !';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextFormField(
                          controller: noteSickLeaveController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Detail",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please insert the detail';
                            }
                            return null;
                          },
                        ),
                      ),
                    )
                  ),
                  Spacer(),
                  MaterialButton(
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 124, 185, 236),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      MemberSickLeaveController memberSickLeaveController = MemberSickLeaveController();
                      if (sickLeaveKey.currentState!.validate()) {
                        memberSickLeaveController.insertPengajuan().then((value) {
                          if (value == true) {
                            Get.offAll(() => ListPengajuanSakit());
                            final snackBar = SnackBar(
                                content: const Text("Success Insert Request")
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            dateSickLeaveController.clear();
                            noteSickLeaveController.clear();
                          } else {
                              final snackBar = SnackBar(
                                  content: const Text("Failure Insert Request")
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                        });
                      } 
                    },
                  ),
                ],
              ),
            )
          )
        ),
      )
    );
  }
}