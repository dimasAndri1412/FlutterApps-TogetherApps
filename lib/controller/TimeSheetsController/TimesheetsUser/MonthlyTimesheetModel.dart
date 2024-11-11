import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/OvertimeModel.dart';

class MonthlyTimesheetModel{
  final DateTime? clockIn;
  final String? location;
  final String? shift;
  final DateTime? clockOut;
  final String? elapsedTime;
  final List<String>? questionText;
  final List<String>? answerText;
  final OvertimeModel? overtime;
  final List<String>? platform;
  final String? clockOutId;
  final String? grup;
  final String? fullName;

  MonthlyTimesheetModel({
    this.clockIn,
    this.location,
    this.shift,
    this.clockOut,
    this.clockOutId,
    this.elapsedTime,
    this.questionText,
    this.overtime,
    this.answerText,
    this.platform,
    this.grup,
    this.fullName
  });

  factory MonthlyTimesheetModel.fromJson(Map<String, dynamic> json){
    return MonthlyTimesheetModel(
      clockIn: json['clock_in'] != null ? DateTime.parse(json['clock_in']) : null,
      location: json['location'] as String?,
      shift: json['shift'] as String?,
      clockOut: json['clock_out'] != null ? DateTime.parse(json['clock_out']) : null,
      clockOutId: json['clock_out_id'] as String?,
      elapsedTime: json['elapsed_time'] as String?,
      questionText: json['questions'] != null ? List<String>.from(json['questions']) : null,
      answerText: json['answers'] != null ? List<String>.from(json['answers']) : null,
      platform: json['platform'] != null ? List<String>.from(json['platform']) : null,
      overtime: json['overtime'] != null ? OvertimeModel.fromJson(json['overtime']) : null,
      grup: json['grup'] as String?,
      fullName: json['full_name'] as String?,
    );
  }
}


//  "clock_in": "2024-09-23 10:53:12",
//   "location": "bri",
//   "shift": "non",
//   "clock_out": "2024-09-23 14:17:12",
//   "elapsed_time": "03:24:00",
//   "question_text": "What job are you running today?",
//   "answer_text": "Ya"