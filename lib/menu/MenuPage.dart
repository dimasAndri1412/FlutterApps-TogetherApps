import 'package:absent_project/MapsViews/MapsViewPage/GoogleMapsPages.dart';
import 'package:absent_project/controller/LoginController.dart';
import 'package:absent_project/login/LoginPage.dart';
import 'package:absent_project/menu/KPI%20Question/positionList.dart';
import 'package:absent_project/menu/adminManagement/ListUser.dart';
// import 'package:first_project/login/setting/admin.dart' as admin;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final loginController = Get.put(LoginController());
  final box = GetStorage();
  bool isDeviceLockEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDeviceLockEnabled = box.read('isDeviceLockEnabled') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            "Setting",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
        ListTile(
          title: Text("Admin Management"),
          leading: Icon(Icons.people_outline_rounded),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ListUser()),
            );
          },
        ),
        Divider(
          color: Colors.grey,
        ),
        ListTile(
          title: Text("KPI Questions"),
          leading: Icon(Icons.question_mark_outlined),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const kpiQuestion()),
            );
          },
        ),
        Divider(
          color: Colors.grey,
        ),
        ListTile(
          title: Text("Locations"),
          leading: Icon(Icons.location_pin),
          onTap: () {
            Get.offAll(() => googleMapsPages());
          },
        ),
        Divider(
          color: Colors.grey,
        ),
        SwitchListTile(
          title: Text("Device Lock"),
          secondary: Icon(Icons.devices),
          value: isDeviceLockEnabled,
          onChanged: (bool value) {
            setState(() {
              isDeviceLockEnabled = value;
              box.write('isDeviceLockEnabled', value); // Save state
              print("Switch saat ini: $isDeviceLockEnabled");
            });
          },
        ),
        Divider(
          color: Colors.grey,
        ),
        ListTile(
          title: Text("LOG OUT"),
          leading: Icon(Icons.logout),
          onTap: () {
            _showConfirmDialog(context);
          },
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  itemMenu(String title, String subtitle, IconData iconData) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: Icon(iconData),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ListUser()),
            );
          },
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  itemMenuLocation(
      String titleLocation, String subtitle, IconData iconDataLocation) {
    return Column(
      children: [
        ListTile(
          title: Text(titleLocation),
          leading: Icon(iconDataLocation),
          onTap: () {
            Get.offAll(() => googleMapsPages());
          },
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  //dialog confirmation
  Future<Future<bool?>> _showConfirmDialog(BuildContext context) async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Icon(Icons.warning_amber, color: Colors.deepOrange),
            title: Text(
              "Attentions!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text("ARE YOU SURE WANT TO EXIT WITHOUT SAVE"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "NO",
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.offAll(() => LoginPage());
                },
                child: Text(
                  "YES",
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }
}
