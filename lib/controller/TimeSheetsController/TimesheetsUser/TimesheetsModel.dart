import 'package:intl/intl.dart';

class TimesheetsModel {
  final DateTime? clockIn;
  final DateTime? clockOut;
  final String? elapsedTime;

  TimesheetsModel({this.clockIn, this.clockOut, this.elapsedTime});

  factory TimesheetsModel.fromJson(Map<String, dynamic> json){
    return TimesheetsModel(
      clockIn: json['clock_in'] != null ? DateTime.parse(json['clock_in']) : null,
      clockOut: json['clock_out'] != null ? DateTime.parse(json['clock_in']) : null,
      elapsedTime: json['elapsed_time'] as String?
    );
  }

  String? timeFormat(DateTime? datetime) {
    if (datetime == null) return null;
    return DateFormat.Hm().format(datetime);
  }
}