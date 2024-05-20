// import 'package:first_project/login/setting/admin.dart' as admin;
import 'package:absent_project/menu/PersonalSettings/personal_setting.dart';
import 'package:absent_project/menu/adminManagement/DetailUser.dart';
import 'package:flutter/material.dart';

class MenuPageUser extends StatefulWidget {
  const MenuPageUser({super.key});

  @override
  State<MenuPageUser> createState() => _MenuPageUserState();
}

class _MenuPageUserState extends State<MenuPageUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "User Settings",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text("Personal Setting"),
            leading: Icon(Icons.manage_accounts),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PersonalSetting()),
              );
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Time off"),
            leading: Icon(Icons.cases_outlined),
            onTap: () {},
          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
