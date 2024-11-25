import 'package:absent_project/SA/model/Companies.dart';
import 'package:absent_project/SA/model/Divisions.dart';
import 'package:absent_project/SA/model/Positions.dart';
import 'package:absent_project/SA/model/Projects.dart';
import 'package:absent_project/SA/model/Users.dart';

class ListUsersJson{
  Users user;
  Companies company;
  Divisions division;
  Projects project;
  Positions position;

  ListUsersJson({
    required this.user,
    required this.company,
    required this.division,
    required this.project,
    required this.position
  });

  factory ListUsersJson.fromJson(Map<String,dynamic> json){
    return ListUsersJson(
      user: Users(
          id: json['user']['id'] ?? 0,
          username: json['user']['username'] ?? '',
          email_address: json['user']['email'] ?? '',
          full_name: json['user']['full_name'] ?? '',
          phone_number: json['user']['phone_number'] ?? '',
          address: json['user']['address'] ?? '',
          birth_date: json['user']['birth_date'] ?? '',
          company_name: json['company_name'] ?? '',
          division_name: json['division_name'] ?? '',
          project_name: json['project_name'] ?? '',

      ),
        company: Companies(
            id: json['company']['id'] ?? 0,
            company_name: json['company']['company_name'] ?? '',
        ),
        division: Divisions(id: json['division']['id'],
            division_name: json['division']['division_name'] ?? ''),
        project: Projects(id: json['project']['id'],
            project_name: json['project']['project_name'] ?? ''),
        position: Positions(
            id: json['position']['id'],
            position_name: json['position']['position_name'] ?? ''
        )
    );
  }
}