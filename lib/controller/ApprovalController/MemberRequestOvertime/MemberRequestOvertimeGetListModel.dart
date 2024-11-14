class MemberRequestOvertimeGetListModel {
  final String full_name;
  final String position;
  final String project;
  final String department;
  final String location;
  final String shift;
  final String start_date;
  final String start_time;
  final String end_time;
  final String activity;
  final String status;
  final String reqNo;
  final String submittedDate;
  final String reason_rejected;

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
      position: json['position_name'] ?? 'Unknown',
      project: json['project_name'] ?? 'Unknown',
      department: json['division_name'] ?? 'Unknown',
      location: json['location'] ?? 'Unknown',
      shift: json['shift'] ?? 'Unknown',
      start_date: json['start_date'] ?? 'Unknown',
      start_time: json['start_time'] ?? 'Unknown',
      end_time: json['end_time'] ?? 'Unknown',
      activity: json['activity'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
      reqNo: json['req_no'] ?? 'Unknown',
      submittedDate: json['submittedDate'] ?? 'Unknown',
      reason_rejected: json['reason_rejected'] ?? 'Unknown',
    );
  }

  // Override toString untuk debugging
  @override
  String toString() {
    // TODO: implement toString
    return 'MemberRequestOvertimeGetListModel(full_name: $full_name, position: $position, project: $project, department:$department, location: $location,shift: $shift,start_date: $start_date,start_time: $start_time, end_time: $end_time, activity: $activity, status: $status, reqNo: $reqNo, submittedDate: $submittedDate, reason_rejected: $reason_rejected)';
  }
}
