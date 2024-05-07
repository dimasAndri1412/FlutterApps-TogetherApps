import 'package:absent_project/menu/admin/admin.dart';
// import 'package:first_project/login/setting/admin.dart' as admin;
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
          children:  [
            ListTile(
              title: Text("Admin Management"),
              leading: IconButton(
                onPressed: (){
                  Navigator.push(
                     context,
                      MaterialPageRoute(builder: (context) => const Admin()),
                    );
                }, 
                icon: Icon(Icons.admin_panel_settings)
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        );
  }
}