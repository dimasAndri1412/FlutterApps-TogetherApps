class AdminApprovalOvertimeModel {
  String full_name;
  String position;
  String project;
  String department;
  List<String> location; // Tambahkan daftar lokasi
  String shift;
  String start_date;
  String start_time;
  String end_time;
  String activity;
  String status;
  String reqNo;
  String submittedDate;
  String reason_rejected;
  String approved_by;
  bool selected;

  AdminApprovalOvertimeModel({
    required this.full_name,
    required this.position,
    required this.project,
    required this.department,
    required this.location, // Inisialisasi locations
    required this.shift,
    required this.start_date,
    required this.start_time,
    required this.end_time,
    required this.activity,
    required this.status,
    required this.reqNo,
    required this.submittedDate,
    required this.reason_rejected,
    required this.approved_by,
    this.selected = false,
  });
  factory AdminApprovalOvertimeModel.fromJson(Map<String, dynamic> json) {
    return AdminApprovalOvertimeModel(
      full_name: json['full_name'] ?? 'Unknown',
      position: json['position_name'] ?? 'Unknown',
      project: json['project_name'] ?? 'Unknown',
      department: json['division_name'] ?? 'Unknown',
      location: json['location']?.split(',') ??
          [], // Asumsikan API mengembalikan string dengan koma
      shift: json['shift'] ?? 'Unknown',
      start_date: json['start_date'] ?? 'Unknown',
      start_time: json['start_time'] ?? 'Unknown',
      end_time: json['end_time'] ?? 'Unknown',
      activity: json['activity'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
      reqNo: json['reqNo'] ?? 'Unknown',
      submittedDate: json['submittedDate'] ?? 'Unknown',
      reason_rejected: json['reason_rejected'] ?? 'Unknown',
      approved_by: json['approved_by'] ?? 'Unknown',
    );
  }

  @override
  String toString() {
    return 'MemberRequestOvertimeGetListModel{activity: $activity, start_date: $start_date, full_name: $full_name, status: $status}';
  }
}
