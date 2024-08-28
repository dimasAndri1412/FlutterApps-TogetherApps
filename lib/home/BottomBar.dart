import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GmapsElapsedTimePages.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationPage.dart';
import 'package:absent_project/timesheets/AdminPage/Timesheets.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/home/Home.dart';
import 'package:absent_project/menu/MenuPage.dart';
import 'package:absent_project/approvalls/Approvalls.dart';
import 'package:absent_project/controller/AbsentController/ClockInState.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  // int currentIndex = 0;
  // List<Widget> body = [
  //   Home(),
  //   // gmapsLocationPages(),
  //   ClockInState.hasClockedIn ? gmapsElapsedTimesPages() : gmapsLocationPages(),
  //   Timesheets(),
  //   Approvalls(),
  //   MenuPage()
  // ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<ClockInState>(
      builder: (context, clockInState, child) {
        List<Widget> body = [
          Home(),
          clockInState.hasClockedIn ? gmapsElapsedTimesPages() : gmapsLocationPages(),
          Timesheets(),
          Approvalls(),
          MenuPage()
        ];
        return Scaffold(
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
    );
    // contoh notifikasi
  }
}
