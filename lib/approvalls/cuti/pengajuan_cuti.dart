import 'dart:io';

import 'package:absent_project/approvalls/cuti/add_cuti_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

class PengajuanCuti extends StatefulWidget {
  const PengajuanCuti({super.key});

  @override
  State<PengajuanCuti> createState() => _PengajuanCutiState();
}

class _PengajuanCutiState extends State<PengajuanCuti> {
  final reasonCutiController = TextEditingController();
  final _dateFromController = TextEditingController();
  final _dateUntilController = TextEditingController();

  //Untuk Upload File
  List pickedFiles = [];

  pickFiles() async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    print(result);

    if (result != null) {
      setState(() {
        pickedFiles = result.files.map((file) => File(file.path!)).toList();
      });
    }
  }

  openFile(file) {
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 147, 195, 234),
              Color.fromARGB(255, 98, 171, 232),
              Color.fromARGB(255, 123, 185, 235),
            ]),
          ),
        ),
        elevation: 0,
        title: Text(
          "Leave Application Form",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            Padding(
              // padding: const EdgeInsets.only(left: 30, right: 30, top: 160),
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Container(
                width: 390,
                // height: 400,
                height: 700,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 147, 195, 234),
                        blurRadius: 15,
                        offset: Offset(5, 5))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: Form(
                      child: Column(
                    children: [
                      // SizedBox(height: 50),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Reason of Leave",
                              hintText: "Please input your reason here",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          controller: reasonCutiController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your reason here';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Start from :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Date Leave",
                              hintText: "Please enter your date leave",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.calendar_today)),
                          readOnly: true,
                          controller: _dateFromController,
                          onTap: () async {
                            await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100))
                                .then((selectedDate) {
                              if (selectedDate != null) {
                                _dateFromController.text =
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
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Until :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Date Leave",
                              hintText: "Please enter your date leave",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.calendar_today)),
                          readOnly: true,
                          controller: _dateUntilController,
                          onTap: () async {
                            await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100))
                                .then((selectedDate) {
                              if (selectedDate != null) {
                                _dateUntilController.text =
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
                      SizedBox(
                        height: 10,
                      ),
                      //BUTTON UPLOAD
                      SizedBox(
                        height: 9,
                      ),
                      ElevatedButton(
                        child: Text("Upload"),
                        onPressed: pickFiles,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      pickedFiles.isNotEmpty
                          ? ListView.builder(
                              itemCount: pickedFiles.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => openFile(pickedFiles[index]),
                                  child: Card(
                                    child: ListTile(
                                      leading: returnLogo(pickedFiles[index]),
                                      subtitle: Text(
                                        'File: ${pickedFiles[index].path}',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(),
                      //BUTTON SUBMIT
                      addCutiButton(),
                    ],
                  )),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  //LOGO hasil Upload File
  returnLogo(file) {
    var ex = extension(file.path);

    if (ex == '.pdf') {
      return Icon(
        Icons.picture_as_pdf_sharp,
        color: Colors.amber,
      );
    } else {
      return Icon(
        Icons.question_mark_outlined,
        color: Colors.grey,
      );
    }
  }
}
