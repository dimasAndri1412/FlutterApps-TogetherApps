class Users {
  String username;
  String password;
  String role;
  String full_name;
  String phone_number;
  String birth_date;
  String address;
  String shiftingStatus;
  String email;
  int login_flag;
  String image_path;
  int leave_used;
  int remaining_leave;
  String device;

  Users({
    required this.username,
    required this.password,
    required this.role,
    required this.full_name,
    required this.phone_number,
    required this.birth_date,
    required this.address,
    required this.shiftingStatus,
    required this.email,
    required this.login_flag,
    required this.image_path,
    required this.leave_used,
    required this.remaining_leave,
    required this.device,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "role": role,
      "full_name": full_name,
      "phone_number": phone_number,
      "birth_date": birth_date,
      "address": address,
      "shiftingStatus": shiftingStatus,
      "email_address": email,
      "login_flag": login_flag,
      "image_path": image_path,
      "leave_used": leave_used,
      "remaining_leave": remaining_leave,
      "device": device,
    };
  }
}
