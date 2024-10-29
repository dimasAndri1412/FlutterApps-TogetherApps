class MemberListPaidLeave {
  // String name;
  // String startDateLeave;
  // String status;
  // String reasonLeave;
  String name;
  String date_start_leave;
  String status;
  String reason_leave;
  String reason_rejected;

  MemberListPaidLeave({
    required this.name,
    required this.date_start_leave,
    required this.status,
    required this.reason_leave,
    required this.reason_rejected,
  });

  factory MemberListPaidLeave.fromJson(Map<String, dynamic> json) {
    return MemberListPaidLeave(
      name: json['name'],
      date_start_leave: json['date_start_leave'],
      status: json['status'],
      reason_leave: json['reason_leave'],
      reason_rejected: json['reason_rejected'],
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'MemberListPaidLeave{reason_leave: $reason_leave, date_start_leave: $date_start_leave, name: $name, status: $status}';
  }
}
