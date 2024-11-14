class MemberListPaidLeave {
  final String username;
  final String position;
  final String project;
  final String departement;
  final String types_leave;
  final String reason_leave;
  final String name_of_pic;
  final String phoneNumber;
  final String shift;
  final String date_start_leave;
  final String date_end_leave;
  final String date_back_to_work;
  final String reqNo;
  final String status;
  final String submittedDate;
  final String reason_rejected;
  final int leave_used;
  final int remaining_leave;
  final int jumlah_hari;

  MemberListPaidLeave({
    required this.username,
    required this.position,
    required this.project,
    required this.departement,
    required this.types_leave,
    required this.reason_leave,
    required this.name_of_pic,
    required this.phoneNumber,
    required this.shift,
    required this.date_start_leave,
    required this.date_end_leave,
    required this.date_back_to_work,
    required this.reqNo,
    required this.status,
    required this.submittedDate,
    required this.reason_rejected,
    required this.leave_used,
    required this.remaining_leave,
    required this.jumlah_hari,
  });

  factory MemberListPaidLeave.fromJson(Map<String, dynamic> json) {
    return MemberListPaidLeave(
      username: json['name'] ?? '',
      position: json['position'] ?? '',
      project: json['project'] ?? '',
      departement: json['departement'] ?? '',
      types_leave: json['types_leave'] ?? '',
      reason_leave: json['reason_leave'] ?? '',
      name_of_pic: json['name_of_pic'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      shift: json['shift'] ?? '',
      date_start_leave: json['date_start_leave'] ?? '',
      date_end_leave: json['date_end_leave'] ?? '',
      date_back_to_work: json['date_back_to_work'] ?? '',
      reqNo: json['req_no'] ?? '',
      status: json['status'] ?? '',
      submittedDate: json['submittedDate'] ?? '',
      reason_rejected: json['reason_rejected'] ?? '',
      leave_used: json['leave_used'] ?? 0,
      remaining_leave: json['remaining_leave'] ?? 0,
      jumlah_hari: json['jumlah_hari'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'MemberListPaidLeave{reason_leave: $reason_leave, date_start_leave: $date_start_leave, date_end_leave: $date_end_leave, name: $username, status: $status, jumlah_hari: $jumlah_hari}';
  }
}
