import 'package:absent_project/menu/adminManagement/ListUser.dart';
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
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text("Setting", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Admin Management"),
              leading:Icon(Icons.people_outline_rounded),
              onTap: (){
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

  itemMenu(String title, String subtitle, IconData iconData) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading:Icon(iconData),
          onTap: (){
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
}


