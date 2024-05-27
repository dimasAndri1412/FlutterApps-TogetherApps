import 'dart:io';

import 'package:absent_project/approvalls/lembur/add_lembur_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

class PengajuanLembur extends StatefulWidget {
  const PengajuanLembur({super.key});

  @override
  State<PengajuanLembur> createState() => _PengajuanLemburState();
}

class _PengajuanLemburState extends State<PengajuanLembur> {
  final reasonLemburController = TextEditingController();
  final _dateLemburController = TextEditingController();

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
          "Overtime Application Form",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 160, left: 30, right: 30),
                child: Container(
                  width: 390,
                  // height: 300,
                  height: 450,
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
                    padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                    child: Form(
                        child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Reason of Overtime",
                                hintText: "Please input you reason here",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                            controller: reasonLemburController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your reason here';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black))),
                            child: DropdownSearch<String>(
                              popupProps: PopupProps.dialog(
                                showSelectedItems: true,
                                // disabledItemFn: (String s) => s.startsWith('I'),
                              ),
                              items: [
                                "Shift I",
                                "Shift II",
                                "Shift III",
                              ],
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Your Shift",
                                  hintText: "Choose your shift !",
                                ),
                              ),
                              // onChanged: print,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your reason here';
                                }
                                return null;
                              },
                            )),
                        SizedBox(height: 10),
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
                            controller: _dateLemburController,
                            onTap: () async {
                              await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100))
                                  .then((selectedDate) {
                                if (selectedDate != null) {
                                  _dateLemburController.text =
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
                        ElevatedButton(
                          child: Text(
                            "Upload PDF",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: pickFiles,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //NOTIFICATION HASIL UPLOAD
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
                        SizedBox(height: 10),
                        //BUTTON SUBMIT
                        addLemburButton(),
                      ],
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
