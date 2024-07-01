class AdminApprovalOvertimeModel{
  String full_name;
  String position;
  String project;
  String department;
  String shift;
  String start_date;
  String start_time;
  String end_time;
  String activity;
  String status;
  String reqNo;
  String submittedDate;

  AdminApprovalOvertimeModel({
    required this.full_name,
    required this.position,
    required this.project,
    required this.department,
    required this.shift,
    required this.start_date,
    required this.start_time,
    required this.end_time,
    required this.activity,
    required this.status,
    required this.reqNo,
    required this.submittedDate,
  });
  factory AdminApprovalOvertimeModel.fromJson(Map<String, dynamic> json) {
    return AdminApprovalOvertimeModel(
      full_name: json['full_name'],
      position: json['position'],
      project: json['project'],
      department: json['department'],
      shift: json['shift'],
      start_date: json['start_date'],
      start_time: json['start_time'],
      end_time: json['end_time'],
      activity: json['activity'],
      status: json['status'],
      reqNo: json['reqNo'],
      submittedDate: json['submittedDate'],
    );
  }

  @override
  String toString() {
    return 'MemberRequestOvertimeGetListModel{activity: $activity, start_date: $start_date, full_name: $full_name, status: $status}';
  }
}

