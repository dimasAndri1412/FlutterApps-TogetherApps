class Users {
  String username;
  String password;
  String full_name;
  String phone_number;
  String birth_date;
  String address;
  String email;

  Users({
    required this.username,
    required this.password,
    required this.full_name,
    required this.phone_number,
    required this.birth_date,
    required this.address,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "full_name": full_name,
      "phone_number": phone_number,
      "birth_date": birth_date,
      "address": address,
      "email_address": email,
    };
  }
}
