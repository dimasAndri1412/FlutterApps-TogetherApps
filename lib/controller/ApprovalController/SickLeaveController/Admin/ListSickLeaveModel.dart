class ListSickLeaveModel {
  final String reqId;
  final String fullName;
  final String projectName;
  final String positionName;
  final String divisionName;
  final String companyName;
  final String phoneNumber;
  final DateTime? date;
  final String note;
  final String status;
  final String approvedBy;
  final DateTime? actionDate;
  final DateTime? submittedDate;
  final String rejectedReason;

  ListSickLeaveModel({
    required this.reqId,
    required this.fullName,
    required this.projectName,
    required this.positionName,
    required this.divisionName,
    required this.companyName,
    required this.phoneNumber,
    required this.date,
    required this.note,
    required this.status,
    required this.approvedBy,
    required this.actionDate,
    required this.submittedDate,
    required this.rejectedReason
  });

  factory ListSickLeaveModel.fromJson(Map<String, dynamic> json){
    return ListSickLeaveModel(
      reqId: json['request_id'] ?? " ",
      fullName: json['full_name'] ?? " ",
      projectName: json['project_name'] ?? " ",
      positionName: json['position_name'] ?? " ",
      divisionName: json['division_name'] ?? " ",
      companyName: json['company_name'] ?? " ",
      phoneNumber: json['phone_number'] ?? " ",
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      note: json['note'] ?? " ",
      status: json['status'] ?? " ",
      approvedBy: json['approved_by'] ?? "Not yet approved",
      actionDate: json['action_date'] != null ? DateTime.parse(json['action_date']) : null,
      submittedDate: json['submitted_date'] != null ? DateTime.parse(json['submitted_date']) : null,
      rejectedReason: json['rejected_reason'] ?? " ",
    );
  }
}