import '../MemberRequestPaidLeave/MemberListPaidLeave.dart';

class AdminApprovalPaidLeaveModel {
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

  AdminApprovalPaidLeaveModel({
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
    required this.jumlah_hari
  });

  factory AdminApprovalPaidLeaveModel.fromJson(Map<String, dynamic> json) {
    return AdminApprovalPaidLeaveModel(
      username: json['name'],
      position: json['position'],
      project: json['project'],
      departement: json['departement'],
      types_leave: json['types_leave'],
      reason_leave: json['reason_leave'],
      name_of_pic: json['name_of_pic'],
      phoneNumber: json['phone_number'],
      shift: json['shift'],
      date_start_leave: json['date_start_leave'],
      date_end_leave: json['date_end_leave'],
      date_back_to_work: json['date_back_to_work'],
      reqNo: json['reqNo'],
      status: json['status'],
      submittedDate: json['submittedDate'],
      reason_rejected: json['reason_rejected'],
      leave_used: json['leave_used'],
      remaining_leave: json['remaining_leave'],
      jumlah_hari: json['jumlah_hari']
    );
  }

  factory AdminApprovalPaidLeaveModel.fromMemberList(MemberListPaidLeave member) {
    print("Converting from MemberListPaidLeave to AdminApprovalPaidLeaveModel:");
    print("Remaining leave: ${member.remaining_leave}");
    return AdminApprovalPaidLeaveModel(
      reqNo: member.req_no,
      username: member.name,
      position: member.position,
      project: member.project,
      departement: member.departement,
      types_leave: member.types_leave,
      reason_leave: member.reason_leave,
      name_of_pic: member.name_of_pic,
      phoneNumber: member.phoneNumber,
      shift: member.shift,
      date_start_leave: member.date_start_leave,
      date_end_leave: member.date_end_leave,
      date_back_to_work: member.date_back_to_work,
      status: member.status,
      submittedDate: member.submittedDate,
      reason_rejected: member.reason_rejected,
      leave_used: member.leave_used,
      remaining_leave: member.remaining_leave,
      jumlah_hari: member.jumlah_hari,
    );
  }


  get name => null;
}
