import 'package:absent_project/MapsViews/MapsClockInElapsedTime/GmapsElapsedTimePages.dart';
import 'package:absent_project/MapsViews/MapsLocationPages/GmapsLocationPage.dart';
import 'package:absent_project/approvalls/approvalls_user.dart';
import 'package:absent_project/approvalls/cuti/user/list_pengajuan_cuti.dart';
import 'package:absent_project/approvalls/lembur/user/list_pengajuan_lembur.dart';
import 'package:absent_project/controller/AbsentController/ClockInState.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeController.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeGetListModel.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberListPaidLeave.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestPaidLeave/MemberRequestPaidLeaveController.dart';
import 'package:absent_project/controller/ApprovalController/NotificationProvider.dart';
import 'package:absent_project/controller/ApprovalController/notification_model.dart';
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
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _initializeNotification();
  }

  Future<void> _initializeNotification() async {
    await fetchOvertimeRequests();
    await fetchPaidLeaveRequest();
  }

  Future<void> fetchOvertimeRequests() async {
    try {
      List<MemberRequestOvertimeGetListModel>? overtimeRequests =
          await MemberRequestOvertimeController().getList();
      if (overtimeRequests != null && overtimeRequests.isNotEmpty) {
        // Filter approved requests
        List<MemberRequestOvertimeGetListModel> approvedRequests =
            overtimeRequests
                .where((request) => request.status == 'Approved')
                .toList();

        // Tambahkan notifikasi untuk setiap permintaan yang disetujui
        if (approvedRequests.isNotEmpty) {
          for (var request in approvedRequests) {
            context.read<NotificationProvider>().addNotification(
                "New Overtime Request Approved (${request.reqNo})", 'overtime');
          }
        }
      }
    } catch (e) {
      print('Error fetching overtime requests: $e');
    }
  }

  Future<void> fetchPaidLeaveRequest() async {
    try {
      List<MemberListPaidLeave>? paidLeaveRequest =
          await MemberRequestPaidLeaveController().getList();
      if (paidLeaveRequest != null && paidLeaveRequest.isNotEmpty) {
        // Filter approved requests
        List<MemberListPaidLeave> approvedRequests = paidLeaveRequest
            .where((request) => request.status == 'Approved')
            .toList();

        // Tambahkan notifikasi untuk setiap permintaan yang disetujui
        if (approvedRequests.isNotEmpty) {
          for (var request in approvedRequests) {
            context.read<NotificationProvider>().addNotification(
                "New Paidleave Request Approved (${request.reqNo})",
                'paidleave');
          }
        }
      }
    } catch (e) {
      print('Error fetching leave requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockInState>(builder: (context, clockInState, child) {
      return Consumer<NotificationProvider>(
          builder: (context, notificationProvider, child) {
        List<NotificationModel> notifications =
            notificationProvider.getNotifications();

        List<Widget> body = [
          UserHome(),
          clockInState.hasClockedIn
              ? gmapsElapsedTimesPages()
              : gmapsLocationPages(),
          TimesheetsUser(),
          ApprovallsUser(),
          MenuPageUser()
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
                  PopupMenuButton<NotificationModel>(
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    onSelected: (NotificationModel selectedNotification) {
                      // Arahkan ke halaman yang sesuai berdasarkan jenis notifikasi
                      if (selectedNotification.type == 'paidleave') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListPengajuanCuti()),
                        );
                      } else if (selectedNotification.type == 'overtime') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListPengajuanLembur()),
                        );
                      }

                      // Hapus notifikasi setelah diklik
                      setState(() {
                        Provider.of<NotificationProvider>(context,
                                listen: false)
                            .removeNotification(selectedNotification);
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      List<NotificationModel> notifications =
                          Provider.of<NotificationProvider>(context,
                                  listen: false)
                              .getNotifications();

                      return notifications.isEmpty
                          ? [
                              PopupMenuItem<NotificationModel>(
                                value: NotificationModel(
                                    message: 'No new notifications', type: ''),
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
                          : notifications.map((NotificationModel notification) {
                              return PopupMenuItem<NotificationModel>(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                  if (Provider.of<NotificationProvider>(context)
                      .getNotifications()
                      .isNotEmpty)
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
                          '${Provider.of<NotificationProvider>(context).getNotifications().length}',
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
    });
  }
}
