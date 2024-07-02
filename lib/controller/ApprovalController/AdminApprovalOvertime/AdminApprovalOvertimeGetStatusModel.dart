class AdminApprovalOvertimeGetStatusModel{
  String status;
  bool selected;

  AdminApprovalOvertimeGetStatusModel({
    required this.status,
    this.selected = false
  });
  factory AdminApprovalOvertimeGetStatusModel.fromJson(Map<String, dynamic> json) {
    return AdminApprovalOvertimeGetStatusModel(
      status: json['status'] ?? '',
    );
  }

  @override
  String toString() {
    return 'AdminApprovalOvertimeGetStatusModel{status: $status}';
  }
}