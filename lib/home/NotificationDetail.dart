import 'package:flutter/material.dart';

class NotificationDetail extends StatefulWidget {
  const NotificationDetail({super.key});

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  final List<Map<String, String>> requests = [
    {
      "name": "Rara Zahra Urava",
      "request": "Paid Leave Request",
      "date" : "13 Jun 2024"
    },
    {
      "name": "Alviliana",
      "request": "Paid Leave Request",
      "date" : "12 Jun 2024"
    },
    {
      "name": "Amelia Desy",
      "request": "Overtime Request",
      "date" : "11 Jun 2024"
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 147, 195, 234),
                Color.fromARGB(255, 98, 171, 232),
                Color.fromARGB(255, 123, 185, 235),
              ]),
            ),
          ),
          elevation: 0,
          title: Text("Notifications",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (BuildContext context, int index){
                  final request = requests[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(),
                        title:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                request["name"]!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text("has submitted a",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              request["request"]!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        subtitle: Text(
                          request["date"]!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                          ),
                        ),
                      ),
                      Divider()
                    ],
                  );
                }
              ),
            )
          ],
        ),  
      )
    );
  }
}