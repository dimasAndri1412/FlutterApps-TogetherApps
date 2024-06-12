import 'package:absent_project/home/NotificationDetail.dart';
import 'package:flutter/material.dart';

class NotificationDialog extends StatefulWidget {
  const NotificationDialog({super.key});

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  final List<Map<String, String>> requests = [
    {
      "title": "Need to Approve",
      "subtitle": "Rara Zahra Urava-Paid Leave Request",
      "trailing" : "2 min ago"
    },
    {
      "title": "Need to Approve",
      "subtitle": "John Doe-Sick Leave Request",
      "trailing" : "1 hour ago"
    },
    {
      "title": "Need to Approve",
      "subtitle": "Alviliana-Overtime Request",
      "trailing" : "1 hour ago"
    },
    {
      "title": "Need to Approve",
      "subtitle": "Choi Beomgyu-Date Request with Razu xixi",
      "trailing" : "1 day ago"
    },
    {
      "title": "Need to Approve",
      "subtitle": "Kim Sunoo-Paid Leave Request",
      "trailing" : "1 day ago"
    },
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40, right: 10),
          child: Align(
            alignment: Alignment.topRight,
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: 320,
                height: 300,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          'Notification',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          'Mark all as read',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.blue
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      // indent: 20,
                      // endIndent: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                      itemCount: requests.length,
                      itemBuilder: (BuildContext context, int index) {
                        final request = requests[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 0),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            title: Text(
                              request["title"]!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            subtitle: Text(
                              request["subtitle"]!,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            trailing: Text(
                              request["trailing"]!,
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.grey
                              ),
                            ),
                          ),
                        );
                      },
                    )
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close',
                            style: TextStyle(
                              color: Colors.red
                            ),),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => NotificationDetail()));
                          },
                          child: Text('See all notifications',
                            style: TextStyle(
                              color: Colors.blue
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}


// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('NotificationDialogs'),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.notificationDialogs),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: Icon(Icons.settings),
//               onPressed: () {},
//             ),
//             CircleAvatar(
//               backgroundImage: NetworkImage(
//                   'https://via.placeholder.com/150'), // URL gambar profil
//             ),
//           ],
//         ),
//         body: NotificationDialogScreen(),
//       ),
//     );
//   }
// }

// class NotificationDialogScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'NotificationDialogs',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: TextButton(
//               onPressed: () {},
//               child: Text('Mark all as read'),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 NotificationDialogItem(
//                   name: 'Michael Scott',
//                   message: "Sent you an invitation to 'Michael's Birthday Party'.",
//                   time: '2 min ago',
//                   avatarUrl: 'https://via.placeholder.com/150', // URL gambar profil
//                   isNew: true,
//                 ),
//                 NotificationDialogItem(
//                   name: 'Michael Scott',
//                   message: "Added a photo to 'Dunder Mifflin' group.",
//                   time: '10 min ago',
//                   avatarUrl: 'https://via.placeholder.com/150', // URL gambar profil
//                   isNew: true,
//                 ),
//                 NotificationDialogItem(
//                   name: 'Dwight Schrute',
//                   message: 'Tagged you in a post.',
//                   time: '14 hours ago',
//                   avatarUrl: 'https://via.placeholder.com/150', // URL gambar profil
//                   isNew: false,
//                 ),
//                 NotificationDialogItem(
//                   name: 'Kevin Malone',
//                   message: "Sent you an invitation to 'Chili's day'.",
//                   time: 'Yesterday',
//                   avatarUrl: 'https://via.placeholder.com/150', // URL gambar profil
//                   isNew: false,
//                 ),
//               ],
//             ),
//           ),
//           Center(
//             child: TextButton(
//               onPressed: () {},
//               child: Text('See all notificationDialogs'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class NotificationDialogItem extends StatelessWidget {
//   final String name;
//   final String message;
//   final String time;
//   final String avatarUrl;
//   final bool isNew;

//   NotificationDialogItem({
//     required this.name,
//     required this.message,
//     required this.time,
//     required this.avatarUrl,
//     required this.isNew,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundImage: NetworkImage(avatarUrl),
//           ),
//           SizedBox(width: 8.0),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       name,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Spacer(),
//                     Text(
//                       time,
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//                 Text(message),
//               ],
//             ),
//           ),
//           if (isNew)
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Icon(
//                 Icons.circle,
//                 color: Colors.red,
//                 size: 10,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }