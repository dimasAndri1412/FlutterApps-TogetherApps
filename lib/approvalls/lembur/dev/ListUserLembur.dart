import 'package:absent_project/approvalls/lembur/dev/DetailLemburUser.dart';
// import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:intl/intl.dart';

class ListUserLembur extends StatefulWidget {
  const ListUserLembur({super.key});

  @override
  State<ListUserLembur> createState() => _ListUserLemburState();
}

class _ListUserLemburState extends State<ListUserLembur> {
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
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text(
            "Overtime Approval for Development Project ",
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
          Expanded(
          child: ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              final statusColor = _getStatusColor(request["status"] ?? "Unknown");
              return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => DetailLemburUser()));
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
                            Text(request["reqNo"]!),
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
                                  request["status"] ?? "New",
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
                                  request["submittedBy"]!,
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
                                  request["date"]!,
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
