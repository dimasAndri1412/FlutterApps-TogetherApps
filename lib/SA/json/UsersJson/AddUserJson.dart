import 'package:absent_project/SA/model/Companies.dart';
import 'package:absent_project/SA/model/Divisions.dart';
import 'package:absent_project/SA/model/Positions.dart';
import 'package:absent_project/SA/model/Projects.dart';

import '../../model/Users.dart';


class AddUserJson {
  Users login;
  Companies company;
  Divisions division;
  Projects project;
  Positions position;

  AddUserJson({
    required this.login,
    required this.company,
    required this.division,
    required this.project,
    required this.position,
  });

  Map<String, dynamic> toJson() {
    return {
      "login": login.toJson(),
      "company": company.toJson(),
      "division": division.toJson(),
      "project": project.toJson(),
      "position": position.toJson(),
    };
  }
}

