import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GmapsElapsedTimePages.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationPage.dart';
import 'package:absent_project/approvalls/approvalls_user.dart';
import 'package:absent_project/controller/AbsentController/ClockInState.dart';
import 'package:absent_project/home/Userhome.dart';
import 'package:absent_project/menu/menu_page_user.dart';
import 'package:absent_project/timesheets/timesheetsUser/timesheets_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationBarUser extends StatefulWidget {
  final int initialIndex;
  const ApplicationBarUser({super.key, this.initialIndex = 0});

  @override
  State<ApplicationBarUser> createState() => _ApplicationBarUserState();
}

class _ApplicationBarUserState extends State<ApplicationBarUser> {
  // int currentIndex = 0;
  // List<Widget> body = [
  //   UserHome(),
  //   // AttendanceScreen(),
  //   gmapsLocationPages(),
  //   TimesheetsUser(),
  //   ApprovallsUser(),
  //   MenuPageUser()
  // ];
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockInState>(builder: (context, clockInState, child) {
      List<Widget> body = [
        UserHome(),
        clockInState.hasClockedIn
            ? gmapsElapsedTimesPages()
            : gmapsLocationPages(),
        TimesheetsUser(),
        ApprovallsUser(),
        MenuPageUser()
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
          automaticallyImplyLeading: false,
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
          actions: [
            Stack(
              children: [
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
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
    });
  }
}
