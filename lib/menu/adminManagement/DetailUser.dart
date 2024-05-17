import 'package:absent_project/controller/ListUserController/ListUserController.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

class DetailUser extends StatefulWidget {
  const DetailUser({super.key});

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rara Zahra Urava",
          style: TextStyle(fontSize: 15),
        ),
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
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
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
                                color: Colors.black.withOpacity(0.1))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://picsum.photos/id/1/200/300"))),
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
                              color: Colors.blue),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              itemProfile('Username', 'Rarazu'),
              const SizedBox(height: 10),
              itemProfile('Name', 'Rara Zahra Urava'),
              const SizedBox(height: 10),
              itemProfile('Role', 'Member'),
              const SizedBox(height: 10),
              itemProfile('Group', '-'),
              const SizedBox(
                height: 10,
              ),
              itemProfile('Work Schedule', '-'),
              SizedBox(
                height: 30,
              ),
              Text(
                "Login & Security",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              itemProfile('Email', 'rarazu@gmail.com'),
              const SizedBox(height: 20),
              itemProfile('Phone Number', '1234567'),
              SizedBox(
                height: 30,
              ),
              Text(
                "Date & Time",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              itemProfile('Timezone', '-'),
              const SizedBox(height: 20),
              itemProfile('Timesheet Timezone', '-'),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle) {
    return GestureDetector(
      onTap: () {
        openDialog();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Color.fromARGB(255, 144, 200, 245).withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10),
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

  void openDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Username",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(),
        actions: [
          TextButton(
            onPressed: () {},
            child:
                Text("Update", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

//SCRIPT PUNYA RAZU untuk button pada form//
/* itemProfile(String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Color.fromARGB(255, 144, 200, 245).withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }*/
}
