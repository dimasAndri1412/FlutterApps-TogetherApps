import 'package:absent_project/approvalls/lembur/msdo/DetailLemburUser.dart';
import 'package:absent_project/controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertimeModel.dart';
import 'package:absent_project/controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertmaControlleri.dart';
// import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';

class ListUserLembur extends StatefulWidget {
  const ListUserLembur({super.key});

  @override
  State<ListUserLembur> createState() => _ListUserLemburState();
}

// class Item {
//   final String title;
//   final DateTime dateTime;

//   Item({required this.title, required this.dateTime});
// }

class _ListUserLemburState extends State<ListUserLembur> {
  /*final List<Map<String, String>> requests = [
    {"reqNo": "REQ-1023", "submittedBy": "Rara Zahra Urava", "date": "03 Des 2024 - 12:30", "status": "Approved"},
    {"reqNo": "REQ-1024", "submittedBy": "Kim Sunoo", "date": "04 Des 2024 - 14:00", "status": "Rejected"},
    {"reqNo": "REQ-1025", "submittedBy": "Choi Beomgyu", "date": "05 Des 2024 - 09:15", "status": "New"},
    {"reqNo": "REQ-1025", "submittedBy": "Jeon Jungkook", "date": "06 Des 2024 - 12:15", "status": "New"},
    {"reqNo": "REQ-1025", "submittedBy": "Kim Yoon Woo", "date": "06 Des 2024 - 13:55", "status": "New"},
    {"reqNo": "REQ-1025", "submittedBy": "Byeon Woo Seok", "date": "06 Des 2024 - 10:15", "status": "New"},
    // Add more request items as needed
  ];*/

  @override
  void initState() {
    super.initState();
    fetchOvertimeRequests();
    //fetchStatusOT();
  }
  List<AdminApprovalOvertimeModel> getListUser = [];
  Future<void> fetchOvertimeRequests() async {
    try {
      List<AdminApprovalOvertimeModel>? overtimeRequests =
      await AdminApprovalOvertimaController().getList();
      setState(() {
        getListUser = overtimeRequests!;
      });
    } catch (e) {
      // Handle errors or exceptions here
      print('Error fetching overtime requests: $e');
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'New':
        return Colors.blue;
      default:
        return Colors.blue; // Default color if status is unknown
    }
  }

  String filterStatus = '';

  List<AdminApprovalOvertimeModel> get filteredLembur {
    if (filterStatus == '') {
      return getListUser;
    }
    return getListUser
        .where((lembur) => lembur.status == filterStatus)
        .toList();
  }

  final List<String> statuses = ['New', 'Approved', 'Rejected'];
  String? selectedStatus;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text(
            "Overtime Approval MSDO Project",
            style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // color: Colors.grey,
            width: 290,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterChip(
                    label: Text("New"),
                    selected: filterStatus == 'New',
                    onSelected: (bool selected) {
                      setState(() {
                        filterStatus = selected ? 'New' : '';
                      });
                    },
                  ),
                  FilterChip(
                    label: Text("Approved"),
                    selected: filterStatus == 'Approved',
                    onSelected: (bool selected) {
                      setState(() {
                        filterStatus = selected ? 'Approved' : '';
                      });
                    },
                  ),
                  FilterChip(
                    label: Text("Rejected"),
                    selected: filterStatus == 'Rejected',
                    onSelected: (bool selected) {
                      setState(() {
                        filterStatus = selected ? 'Rejected' : '';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
          child: ListView.builder(
            // itemCount: requests.length,
            itemCount: filteredLembur.length,
            itemBuilder: (context, index) {
              // final request = requests[index];
              final getData = filteredLembur[index];
              final statusColor = _getStatusColor(getData.status ?? "Unknown");
              return GestureDetector(
              onTap: () {
               Get.to(() => DetailLemburUser(getData: getData));
              },
                child : Container(
                  margin: EdgeInsets.all(10),
                  width: 350,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(width: 0.5, color: Colors.grey),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 15, right: 20),
                        child: Row(
                          children: [
                            Text(
                              "No. Req : ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(getData.reqNo),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:statusColor,
                              ),
                              height: 20,
                              width: 80,
                              child: Center(
                                child: Text(
                                  getData.status ?? "New",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/images/workaholism.png', 
                            )
                        ),
                        title: Text(
                          "Overtime Request",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.people_alt_outlined,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Submitted by",
                                  style: TextStyle(fontSize: 12, height: 2),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  getData.full_name,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.blue),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  getData.submittedDate,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              );
            },
          ),
        ),
        ],
      )
    );
  }
}
