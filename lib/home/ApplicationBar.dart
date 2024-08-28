import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GmapsElapsedTimePages.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationPage.dart';
import 'package:absent_project/timesheets/AdminPage/Timesheets.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/home/Home.dart';
import 'package:absent_project/menu/MenuPage.dart';
import 'package:absent_project/approvalls/Approvalls.dart';
import 'package:absent_project/controller/AbsentController/ClockInState.dart';
import 'package:provider/provider.dart';

class ApplicationBar extends StatefulWidget {
  const ApplicationBar({super.key});

  @override
  State<ApplicationBar> createState() => _ApplicationBarState();
}

class _ApplicationBarState extends State<ApplicationBar> {

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

        int notificationCount = 5;
        List<String> notifications = [
        "Notification 1",
        "Notification 2",
        "Notification 3",
        "Notification 4",
        "Notification 5"
      ];

        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 147, 195, 234),
                        Color.fromARGB(255, 98, 171, 232),
                        Color.fromARGB(255, 123, 185, 235),
                      ]
                    ),
                    
              ),
              
            ),
            elevation: 0,
            actions: [
              Stack(
                children: [
                  PopupMenuButton<String>(
                    icon: Icon(Icons.notifications, color: Colors.white,),
                    onSelected: (String result) {
                      setState(() {
                        notifications.remove(result);
                        notificationCount--;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return notifications.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                  if (notificationCount > 0)
                    Positioned(
                      right: 11,
                      top: 11,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '$notificationCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
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
    );
    // contoh notifikasi
  }
}
