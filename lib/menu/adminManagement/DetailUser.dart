import 'package:absent_project/controller/ListAndDetailUserController/UserList.dart';
import 'package:flutter/material.dart';

class DetailUser extends StatelessWidget {
  final UserList userList;
  DetailUser({super.key,
  required this.userList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rara Zahra Urava",
          style: TextStyle(fontSize: 15),
        ),
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
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
                children: [ Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                )
                              ],
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("https://picsum.photos/id/1/200/300"),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 4, color: Colors.white),
                                color: Colors.blue,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    itemProfile('Username', userList.username),
                    const SizedBox(height: 10),
                    itemProfile('Full Name', userList.fullname),
                    const SizedBox(height: 10),
                    itemProfile('Role', userList.role),
                    const SizedBox(height: 10),
                    itemProfile('Group', userList.grup),
                    const SizedBox(height: 10),
                    itemProfile('Work Schedule', "tomorrow"),
                    const SizedBox(height: 30),
                    const Text(
                      "Login & Security",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    itemProfile('Email', userList.email),
                    const SizedBox(height: 20),
                    itemProfile('Phone Number', userList.phoneNumber),
                    const SizedBox(height: 30),
                    const Text(
                      "Date & Time",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    itemProfile('Timezone', "-"),
                    const SizedBox(height: 20),
                    itemProfile('Timesheet Timezone', "-"),
                  ],
                ),
                ],
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle) {
    return GestureDetector(
      onTap: () {
        /*openDialog();*/
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: const Color.fromARGB(255, 144, 200, 245).withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 10,
            )
          ],
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
          tileColor: Colors.white,
        ),
      ),
    );
  }

 /* void openDialog() {
    showDialog(
      context: BuildContext,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          "Username",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const TextField(),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Update",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),*//*
    );
  }*/
}