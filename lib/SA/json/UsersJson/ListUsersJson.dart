// import 'package:absent_project/SA/model/Companies.dart';
// import 'package:absent_project/SA/model/Divisions.dart';
// import 'package:absent_project/SA/model/Positions.dart';
// import 'package:absent_project/SA/model/Projects.dart';
// import 'package:absent_project/SA/model/Users.dart';
//
// class ListUsersJson{
//   Users user;
//   Companies company;
//   Divisions division;
//   Projects project;
//   Positions position;
//
//   ListUsersJson({
//     required this.user,
//     required this.company,
//     required this.division,
//     required this.project,
//     required this.position
//   });
//
//   factory ListUsersJson.fromJson(Map<String,dynamic> json){
//     return ListUsersJson(
//       user: Users(
//           username: json['user']['username'] ?? '',
//           password: json['user']['password'] ?? '',
//           email: json['user']['email'] ?? '',
//           full_name: json['user']['full_name'] ?? '',
//           role: json['user']['roles'] ?? ''
//       ),
//         company: Companies(company_name: json['company']['company_name'] ?? ''),
//         division: Divisions(division_name: json['division']['division_name'] ?? ''),
//         project: Projects(project_name: json['project']['project_name'] ?? ''),
//         position: Positions(position_name: json['position']['position_name'] ?? '')
//     );
//   }
// }