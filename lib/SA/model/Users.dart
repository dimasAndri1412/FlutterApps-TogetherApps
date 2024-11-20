class Users {
  String? username;
  String? full_name;
  String? phone_number;
  String? birth_date;
  String? address;
  String? email_address;

  Users({
    required this.username,
    required this.full_name,
    required this.phone_number,
    required this.birth_date,
    required this.address,
    required this.email_address,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "full_name": full_name,
      "phone_number": phone_number,
      "birth_date": birth_date,
      "address": address,
      "email_address": email_address,
    };
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      username: json['username'] ?? '',
      full_name: json['full_name'] ?? '',
      phone_number: json['phone_number'] ?? '',
      address: json['address'] ?? '',
      birth_date: json['birth_date'] ?? '',
      email_address: json['email_address'] ?? '',
    );
  }
}
