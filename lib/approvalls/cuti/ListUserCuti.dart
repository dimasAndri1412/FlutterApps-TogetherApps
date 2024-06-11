import 'package:absent_project/approvalls/cuti/DetailCutiUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeaveController.dart';

class ListUserCuti extends StatefulWidget {
  const ListUserCuti({super.key});

  @override
  State<ListUserCuti> createState() => _ListUserCutiState();
}

class _ListUserCutiState extends State<ListUserCuti> {
  final List<Map<String, String>> requests = [
    {"reqNo": "REQ-1023", "submittedBy": "Rara Zahra Urava", "date": "03 Des 2024 - 12:30", "status": "Approved"},
    {"reqNo": "REQ-1024", "submittedBy": "Kim Sunoo", "date": "04 Des 2024 - 14:00", "status": "Rejected"},
    {"reqNo": "REQ-1025", "submittedBy": "Choi Beomgyu", "date": "05 Des 2024 - 09:15", "status": "New"},
    {"reqNo": "REQ-1025", "submittedBy": "Jeon Jungkook", "date": "06 Des 2024 - 12:15", "status": "New"},
    {"reqNo": "REQ-1025", "submittedBy": "Kim Yoon Woo", "date": "06 Des 2024 - 13:55", "status": "New"},
    {"reqNo": "REQ-1025", "submittedBy": "Byeon Woo Seok", "date": "06 Des 2024 - 10:15", "status": "New"},
    // Add more request items as needed
  ];

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

  final List<String> statuses = ['New', 'Approved', 'Rejected'];
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    // List<Map<String, String>> filteredRequests = selectedStatus == null
    //     ? requests
    //     : requests.where((request) => request['status'] == selectedStatus).toList();

    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text(
            "Paid Leave Approval",
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
          SingleChildScrollView(
            child:
          Container(
            margin: EdgeInsets.all(10),
            child: Wrap(
              spacing: 8.0,
              children: statuses.map((status) {
                final isSelected = selectedStatus == status;
                return FilterChip(
                  label: Text(
                    status,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: selectedStatus == status,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedStatus = selected ? status : null;
                    });
                  },
                  selectedColor: Color.fromARGB(255, 225, 161, 101), 
                  checkmarkColor: Colors.white,
                );
              }).toList(),
            ),
          ),
          ),
          FutureBuilder(
              future: UserRequestPaidLeaveController().getUsers(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Text("Loading");
                } else {
                  return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          final getData = snapshot.data![index];
                          final statusColor = _getStatusColor(
                              getData.status ?? "Unknown");
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) => DetailCutiUser()));
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                width: 350,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, top: 15, right: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "No. Req : ",
                                            style: TextStyle(
                                                color: Colors.grey),
                                          ),
                                          Text(getData.reqNo),
                                          Spacer(),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(5),
                                              color: statusColor,
                                            ),
                                            height: 20,
                                            width: 80,
                                            child: Center(
                                              child: Text(
                                                getData.status,
                                                style: const TextStyle(
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
                                            'assets/images/document.png',
                                          )
                                      ),
                                      title: Text(
                                        "Paid Leave Request",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
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
                                                style: TextStyle(
                                                    fontSize: 12, height: 2),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                getData.username,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.blue),
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
                                                getData.date,
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
                    );
              }
              }
              ),
        ],
      )
      );
  }
}
    