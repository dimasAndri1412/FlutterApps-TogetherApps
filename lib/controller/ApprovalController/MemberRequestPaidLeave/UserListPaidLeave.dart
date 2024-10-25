import 'dart:convert';
import 'dart:typed_data';

class UserListPaidleave {
  String username;
  String leave_used;
  String remaining_leave;

  // UserListPaidleave(this.username, this.leave_used, this.remaining_leave);
  UserListPaidleave(
      {required this.username,
      required this.leave_used,
      required this.remaining_leave});

  factory UserListPaidleave.fromJson(Map<String, dynamic> json) {
    return UserListPaidleave(
        username: json['username'],
        leave_used: json['leave_used'],
        remaining_leave: json['remaining_leave']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'UserListPaidleave{username: $username, leave_used: $leave_used, remaining_leave: $remaining_leave}';
  }
}
