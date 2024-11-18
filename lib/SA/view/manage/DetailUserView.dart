// import 'package:flutter/material.dart';
// import 'package:absent_project/SA/json/UsersJson/ListUsersJson.dart';
//
// class DetailUserView extends StatelessWidget {
//   final ListUsersJson user;
//
//   const DetailUserView({Key? key, required this.user}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Detail User"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               user.user.full_name,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               "Company: ${user.company.company_name}",
//               style: const TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Division: ${user.division.division_name}",
//               style: const TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Project: ${user.project.project_name}",
//               style: const TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Position: ${user.position.position_name}",
//               style: const TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Email: ${user.user.email}",
//               style: const TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "username: ${user.user.username}",
//               style: const TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
