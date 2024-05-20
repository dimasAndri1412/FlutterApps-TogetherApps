import 'package:flutter/material.dart';

class PersonalSetting extends StatefulWidget {
  const PersonalSetting({super.key});

  @override
  State<PersonalSetting> createState() => _PersonalSettingState();
}

class _PersonalSettingState extends State<PersonalSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
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
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/LogoBIT.png"))),
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
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SettingProfile('Username', 'Rarazu'),
              const SizedBox(height: 10),
              SettingProfile('Name', 'Rara Zahra Urava'),
              const SizedBox(height: 10),
              SettingProfile('Role', 'Member'),
              const SizedBox(height: 10),
              SettingProfile('Group', '-'),
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
              SettingProfile('Email', 'rarazu@gmail.com'),
              const SizedBox(height: 20),
              itemProfile('Phone Number', '1234567'),
              const SizedBox(
                height: 20,
              ),
              itemProfile('Password', ''),
            ],
          ),
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

  void openDialog() {}
}
