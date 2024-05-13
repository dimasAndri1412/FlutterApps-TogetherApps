import 'package:absent_project/menu/admin/admin.dart';
// import 'package:first_project/login/setting/admin.dart' as admin;
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
          children:  [
            ListTile(
              title: Text("Admin Management"),
              leading:Icon(Icons.admin_panel_settings),
              onTap: (){
                  Navigator.push(
                     context,
                      MaterialPageRoute(builder: (context) => const Admin()),
                    );
                }, 
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        );
  }
}