class MemberRequestOvertimeGetStatusModel{
  String status;
  bool selected;

  MemberRequestOvertimeGetStatusModel({
    required this.status,
    this.selected = false
});
  factory MemberRequestOvertimeGetStatusModel.fromJson(Map<String, dynamic> json) {
    return MemberRequestOvertimeGetStatusModel(
      status: json['status'] ?? '',
    );
  }

  @override
  String toString() {
    return 'MemberRequestOvertimeGetStatusModel{status: $status}';
  }
}