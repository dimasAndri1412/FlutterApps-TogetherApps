class MemberRequestOvertimeGetListModel {
  String activity;
  String start_date;
  String full_name;
  String status;
  String reason_rejected;

  MemberRequestOvertimeGetListModel({
    required this.activity,
    required this.start_date,
    required this.full_name,
    required this.status,
    required this.reason_rejected,
  });

  factory MemberRequestOvertimeGetListModel.fromJson(Map<String, dynamic> json) {
    return MemberRequestOvertimeGetListModel(
      activity: json['activity'],
      start_date: json['start_date'],
      full_name: json['full_name'],
      status: json['status'],
      reason_rejected: json['reason_rejected'],
    );
  }

  @override
  String toString() {
    return 'MemberRequestOvertimeGetListModel{activity: $activity, start_date: $start_date, full_name: $full_name, status: $status}';
  }
}
