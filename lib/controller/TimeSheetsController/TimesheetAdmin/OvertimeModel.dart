import 'package:intl/intl.dart';

class OvertimeModel {
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? activity;
  final String? location;

  OvertimeModel({
    this.date,
    this.startTime,
    this.endTime,
    this.activity,
    this.location
  });

  factory OvertimeModel.fromJson(Map<String, dynamic> json) {
    return OvertimeModel(
      date: json['date'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      activity: json['activity'] as String?,
      location : json['location'] as String?
    );
  }

  String get formattedDate {
    if (date == null) return '-';
    try {
      final parsedDate = DateTime.parse(date!);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return '-';
    }
  }

   String get formattedStartTime {
    if (startTime == null) return '-';
    try {
      final parsedTime = DateTime.parse("2000-01-01 $startTime"); 
      return DateFormat('HH:mm').format(parsedTime);
    } catch (e) {
      return '-';
    }
  }

  String get formattedEndTime {
    if (endTime == null) return '-';
    try {
      final parsedTime = DateTime.parse("2000-01-01 $endTime"); 
      return DateFormat('HH:mm').format(parsedTime);
    } catch (e) {
      return '-';
    }
  }

   String get totalDuration {
    if (startTime == null || endTime == null) return '-';
    try {
      final start = DateTime.parse("2000-01-01 $startTime");
      final end = DateTime.parse("2000-01-01 $endTime");
      final difference = end.difference(start);

      final hours = difference.inHours.toString().padLeft(2, '0');
      final minutes = difference.inMinutes.remainder(60).toString().padLeft(2, '0');
      final seconds = difference.inSeconds.remainder(60).toString().padLeft(2, '0');

      return '$hours:$minutes:$seconds';
    } catch (e) {
      return '-';
    }
  }
}
