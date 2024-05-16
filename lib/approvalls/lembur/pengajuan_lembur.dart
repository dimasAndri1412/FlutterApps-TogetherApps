import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListUserLembur extends StatefulWidget {
  const ListUserLembur({super.key});

  @override
  State<ListUserLembur> createState() => _ListUserLemburState();
}

class _ListUserLemburState extends State<ListUserLembur> {
  final reasonLemburController = TextEditingController();

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
          "Form Pengajuan Lembur",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: 390,
                  height: 600,
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
                    ],
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
