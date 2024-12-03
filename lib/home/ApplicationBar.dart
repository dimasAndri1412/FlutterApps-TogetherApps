import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GmapsElapsedTimePages.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationPage.dart';
import 'package:absent_project/approvalls/cuti/msdo/DetailCutiUser.dart';
import 'package:absent_project/timesheets/AdminPage/Timesheets.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/home/Home.dart';
import 'package:absent_project/menu/MenuPage.dart';
import 'package:absent_project/approvalls/Approvalls.dart';
import 'package:absent_project/controller/AbsentController/ClockInState.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:absent_project/controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeaveController.dart';

// Model class for notifications
class NotificationItem {
  final String message;
  final Widget? targetPage;

  NotificationItem({required this.message, this.targetPage});
}

class ApplicationBar extends StatefulWidget {
  final int initialIndex;
  const ApplicationBar({super.key, this.initialIndex = 0});

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

  // int notificationCount = 5;
  // List<String> notifications = [];
  List<NotificationItem> notifications = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.initialIndex;
    _loadNewLeaveRequest();
  }

  Future<void> _loadNewLeaveRequest() async {
    try {
      var leaveRequest = await AdminApprovalPaidLeaveController().getUsers();
      print("Leave Requests: $leaveRequest");
      if (leaveRequest != null) {
        for (var request in leaveRequest) {
          print("Checking status for request: ${request.status}");
          if (request.status == "New") {
            setState(() {
              // notifications.add("New leave request: ${request.username}");
              notifications.add(NotificationItem(
                  message: "New Leave Request from ${request.username}",
                  targetPage: DetailCutiUser(getUserDetail: request)));
            });
          }
        }
      }
    } catch (e) {
      print("Error loading leave requests: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockInState>(builder: (context, clockInState, child) {
      List<Widget> body = [
        Home(),
        clockInState.hasClockedIn
            ? gmapsElapsedTimesPages()
            : gmapsLocationPages(),
        Timesheets(),
        Approvalls(),
        MenuPage()
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
                PopupMenuButton<NotificationItem>(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onSelected: (NotificationItem selectedNotification) {
                    setState(() {
                      notifications.remove(selectedNotification);
                      // notificationCount--;
                    });

                    if (selectedNotification.targetPage != null) {
                      Get.to(() => selectedNotification.targetPage!);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    // return notifications.map((String choice) {
                    //   return PopupMenuItem<String>(
                    //     value: choice,
                    //     child: Text(choice),
                    //   );
                    // }).toList();
                    return notifications.isEmpty
                        ? [
                            PopupMenuItem<NotificationItem>(
                              value: NotificationItem(
                                  message: "No new notifications"),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'No new notifications',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]
                        : notifications.map((NotificationItem notification) {
                            return PopupMenuItem<NotificationItem>(
                              value: notification,
                              padding: EdgeInsets.only(left: 5, right: 5),
                              // child: Text(notification.message),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0, 2))
                                    ]),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.notifications_active,
                                      color: Colors.blueAccent,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notification.message,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Tap to View Details",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontStyle: FontStyle.italic),
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            );
                          }).toList();
                  },
                ),
                //angka notif kalo ada isi
                if (notifications.isNotEmpty)
                  Positioned(
                    right: 11,
                    top: 11,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '${notifications.length}',
                        style: const TextStyle(
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
    // contoh notifikasi
  }
}
