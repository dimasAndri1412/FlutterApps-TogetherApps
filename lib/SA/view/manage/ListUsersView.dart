// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:absent_project/SA/controller/UserController.dart';
// import 'package:absent_project/SA/json/UsersJson/ListUsersJson.dart';
//
// import 'DetailUserView.dart';
//
// class ListUsersView extends StatefulWidget {
//   @override
//   _ListUsersViewState createState() => _ListUsersViewState();
// }
//
// class _ListUsersViewState extends State<ListUsersView> with SingleTickerProviderStateMixin {
//   late Future<List<ListUsersJson>> users;
//   late AnimationController _animationController;
//   late Animation<Offset> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     users = UserController().fetchUsers();
//
//     // Inisialisasi AnimationController untuk mengontrol pergerakan teks
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);
//
//     // Definisikan animasi untuk teks agar bergerak kiri-kanan
//     _animation = Tween<Offset>(
//       begin: const Offset(-0.1, 0), // Mulai sedikit di kiri
//       end: const Offset(0.1, 0), // Berakhir sedikit di kanan
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Users List'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 8.0, right: 10.0, left:10.0, bottom: 8.0),
//         child: FutureBuilder<List<ListUsersJson>>(
//           future: users,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator()); // Menunggu data
//             } else if (snapshot.hasError) {
//               // Jika terjadi error, tampilkan animasi teks bergulir
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SlideTransition(
//                       position: _animation,
//                       child: const Text(
//                         'Error: Tidak ada koneksi internet',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     SlideTransition(
//                       position: _animation,
//                       child: Text(
//                         'Gagal memuat data pengguna',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return const Center(child: Text('No users found')); // Jika tidak ada data
//             } else {
//               List<ListUsersJson> usersList = snapshot.data!;
//               return ListView.separated(
//                 itemCount: usersList.length,
//                 itemBuilder: (context, index) {
//                   var user = usersList[index];
//                   return Card(
//                     elevation: 5,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.all(16),
//                       title: Text(
//                         user.user.full_name,
//                         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 4),
//                           Text(
//                           user.company.company_name,
//                           style: TextStyle(color: Colors.grey[600]),
//                           )
//                         ]
//                       ),
//                       leading: const Icon(Icons.person, color: Colors.blueAccent),
//                       trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
//                       onTap: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => DetailUserView(user: user)
//                          )
//                        );
//                       },
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) {
//                   return Divider(color: Colors.grey[300], thickness: 1);
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
