class MemberRequestOvertimeGetListModel {
  String activity;
  String start_date;
  String full_name;
  String status;

  MemberRequestOvertimeGetListModel({
    required this.activity,
    required this.start_date,
    required this.full_name,
    required this.status,
  });

  factory MemberRequestOvertimeGetListModel.fromJson(Map<String, dynamic> json) {
    return MemberRequestOvertimeGetListModel(
      activity: json['activity'],
      start_date: json['start_date'],
      full_name: json['full_name'],
      status: json['status'],
    );
  }

  @override
  String toString() {
    return 'MemberRequestOvertimeGetListModel{activity: $activity, start_date: $start_date, full_name: $full_name, status: $status}';
  }
}
