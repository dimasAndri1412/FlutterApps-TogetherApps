class AdminApprovalPadiLeaveGetStatusModel{
  String status;
  bool selected;

  AdminApprovalPadiLeaveGetStatusModel({
    required this.status,
    this.selected = false
  });
  factory AdminApprovalPadiLeaveGetStatusModel.fromJson(Map<String, dynamic> json) {
    return AdminApprovalPadiLeaveGetStatusModel(
      status: json['status'] ?? '',
    );
  }

  @override
  String toString() {
    return 'AdminApprovalPadiLeaveGetStatusModel{status: $status}';
  }
}