import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/AnswersModel.dart';

class MonthlyReportModel{

  final String? location;
  final String? fullName;
  final String? positionName;
  final List<AnswersModel> answers;

  MonthlyReportModel({
    this.location,
    this.fullName,
    required this.answers,
    this.positionName
  });

  factory MonthlyReportModel.fromJson(Map<String, dynamic> json){
    return MonthlyReportModel(
      location: json['location'] as String?,
      fullName: json['full_name'] as String?,
      positionName: json['position_name'] as String?,
      answers: (json['answers'] as List)
          .map((answerJson) => AnswersModel.fromJson(answerJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'location': location,
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }
}