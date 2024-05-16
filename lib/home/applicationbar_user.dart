import 'package:absent_project/home/Userhome.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/menu/MenuPage.dart';
import 'package:absent_project/approvalls/Approvalls.dart';

class ApplicationBar extends StatefulWidget {
  const ApplicationBar({super.key});

  @override
  State<ApplicationBar> createState() => _ApplicationBarState();
}

class _ApplicationBarState extends State<ApplicationBar> {
  int currentIndex = 0;
  List<Widget> body = const [
    UserHome(),
    Icon(Icons.lock_clock),
    Icon(Icons.note),
    Approvalls(),
    MenuPage()
  ];

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
      ),
      body: Center(
        child: body[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 64, 157, 234),
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Time Clock",
            icon: Icon(Icons.lock_clock),
          ),
          BottomNavigationBarItem(
            label: "Timesheets",
            icon: Icon(Icons.note),
          ),
          BottomNavigationBarItem(
            label: "Approvals",
            icon: Icon(Icons.check_circle),
          ),
          BottomNavigationBarItem(
            label: "Menu",
            icon: Icon(Icons.menu),
          )
        ],
      ),
    );
  }
}
