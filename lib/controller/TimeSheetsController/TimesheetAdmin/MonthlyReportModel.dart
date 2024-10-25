import 'package:absent_project/controller/Keys.dart';

class MonthlyReportModel{

  final String? location;
  final String? fullName;
  final String? positionName;
  final List<String>? answerText;

  MonthlyReportModel({
    this.location,
    this.fullName,
    this.answerText,
    this.positionName
  });

  factory MonthlyReportModel.fromJson(Map<String, dynamic> json){
    return MonthlyReportModel(
      location: json['location'] as String?,
      answerText: List<String>.from(json['answers']),
      fullName: json['full_name'] as String?,
      positionName: json['position_name'] as String?,
    );
  }
}