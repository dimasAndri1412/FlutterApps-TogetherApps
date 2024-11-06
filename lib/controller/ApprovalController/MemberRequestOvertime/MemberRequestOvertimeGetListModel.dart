class MemberRequestOvertimeGetListModel {
  String full_name;
  String position;
  String project;
  String department;
  String location;
  String shift;
  String start_date;
  String start_time;
  String end_time;
  String activity;
  String status;
  String reqNo;
  String submittedDate;
  String reason_rejected;

  MemberRequestOvertimeGetListModel({
    required this.full_name,
    required this.position,
    required this.project,
    required this.department,
    required this.location,
    required this.shift,
    required this.start_date,
    required this.start_time,
    required this.end_time,
    required this.activity,
    required this.status,
    required this.reqNo,
    required this.submittedDate,
    required this.reason_rejected,
  });

  factory MemberRequestOvertimeGetListModel.fromJson(
      Map<String, dynamic> json) {
    return MemberRequestOvertimeGetListModel(
      full_name: json['full_name'] ?? 'Unknown', // Nilai default jika null
      position: json['position'] ?? 'Unknown',
      project: json['grup'] ?? 'Unknown',
      department: json['department'] ?? 'Unknown',
      location: json['location'] ?? 'Unknown',
      shift: json['shift'] ?? 'Unknown',
      start_date: json['start_date'] ?? 'Unknown',
      start_time: json['start_time'] ?? 'Unknown',
      end_time: json['end_time'] ?? 'Unknown',
      activity: json['activity'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
      reqNo: json['reqNo'] ?? 'Unknown',
      submittedDate: json['submittedDate'] ?? 'Unknown',
      reason_rejected: json['reason_rejected'] ?? 'Unknown',
    );
  }
}
