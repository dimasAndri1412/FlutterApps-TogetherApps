import 'package:absent_project/ChangePasswordforUser/change_password_user.dart';
import 'package:absent_project/ChangesPasswordPage/ChangesPasswordMenu.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/MemberInfoController/detailMember.dart';

enum _MenuDropdown {
  editpwd,
  logout,
}

class PersonalSetting extends StatefulWidget {
  const PersonalSetting({super.key});

  @override
  State<PersonalSetting> createState() => _PersonalSettingState();
}

class _PersonalSettingState extends State<PersonalSetting> {
  // List<String> menuPojok = [
  //   "Edit Password",
  //   "Log Out",
  // ];

  //untuk obscure password
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<_MenuDropdown>(
            color: Color.fromARGB(255, 185, 215, 237),
            icon: Icon(Icons.menu),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Change Password"),
                value: _MenuDropdown.editpwd,
              ),
              PopupMenuItem(
                child: Text("Log Out"),
                value: _MenuDropdown.logout,
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case _MenuDropdown.editpwd:
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChangePasswordUser()));
                  break;
                case _MenuDropdown.logout:
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => LoginPage()));
                  _showLogoutConfirmationDialog();
                  break;
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: FutureBuilder(
              future: detailMember().getUsers(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Text("Loading");
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, int index) {
                        var user = snapshot.data![index];
                        return Column(
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4, color: Colors.white),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              color:
                                                  Colors.black.withOpacity(0.1))
                                        ],
                                        shape: BoxShape.circle,
                                        image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "assets/images/LogoBIT.png"))),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 4, color: Colors.white),
                                            color: Colors.blue),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            SettingProfile('Username', user.username),
                            const SizedBox(height: 10),
                            SettingProfile('Name', user.fullname),
                            const SizedBox(height: 10),
                            SettingProfile('Role', user.role),
                            const SizedBox(height: 10),
                            SettingProfile('Group', user.grup),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Login & Security",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            SettingProfile('Email', user.email),
                            const SizedBox(height: 20),
                            itemProfile('Phone Number', user.phoneNumber),
                            const SizedBox(
                              height: 20,
                            ),
                            itemProfile(
                                'Password',
                                _isObscure
                                    ? '••••••••'
                                    : passwordController.text),
                          ],
                        );
                      });
                }
              }),
        ),
      ),
    );
  }

  //WIDGET FOR NON SETTING
  Widget SettingProfile(String title, String subtitle) {
    return GestureDetector(
      // onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: const Color.fromARGB(255, 144, 200, 245).withOpacity(.2),
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

  //WIDGET FOR SETTING
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
                offset: const Offset(0, 5),
                color: const Color.fromARGB(255, 144, 200, 245).withOpacity(.2),
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

  //SHOW DIALOG KE LOGIN PAGE
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(
            Icons.warning_amber,
            color: Colors.deepOrange,
          ),
          title: Text(
            'Confirmation!',
            style: TextStyle(
                color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          content: Text('ARE YOU SURE WANT TO LOG OUT ?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Get.offAll(LoginPage());
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => LoginPage()),
                // );
              },
            ),
          ],
        );
      },
    );
  }

  //
  void openDialog() {}
}
