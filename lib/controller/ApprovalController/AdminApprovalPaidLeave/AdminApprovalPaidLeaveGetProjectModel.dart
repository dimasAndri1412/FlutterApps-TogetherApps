class AdminApprovalPaidLeaveGetProjectModel{
  String project;
  bool selected;

  AdminApprovalPaidLeaveGetProjectModel({
    required this.project,
    this.selected = false
  });
  factory AdminApprovalPaidLeaveGetProjectModel.fromJson(Map<String, dynamic> json) {
    return AdminApprovalPaidLeaveGetProjectModel(
      project: json['project'] ?? '',
    );
  }

  @override
  String toString() {
    return 'AdminApprovalOvertimeGetProjectModel{status: $project}';
  }
}