class AdminApprovalOvertimeGetProjectModel{
  String project;
  bool selected;

  AdminApprovalOvertimeGetProjectModel({
    required this.project,
    this.selected = false
  });
  factory AdminApprovalOvertimeGetProjectModel.fromJson(Map<String, dynamic> json) {
    return AdminApprovalOvertimeGetProjectModel(
      project: json['project'] ?? '',
    );
  }

  @override
  String toString() {
    return 'AdminApprovalOvertimeGetProjectModel{status: $project}';
  }
}