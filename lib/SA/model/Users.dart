class Users {
  int? id;
  String? username;
  String? full_name;
  String? phone_number;
  String? birth_date;
  String? address;
  String? email_address;
  String? company_name;
  String? division_name;
  String? project_name;

  Users({
    required this.id,
    required this.username,
    required this.full_name,
    required this.phone_number,
    required this.birth_date,
    required this.address,
    required this.email_address,
    required this.company_name,
    required this.division_name,
    required this.project_name,

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
      id: json['id'] ?? 0 ,
      username: json['username'] ?? '',
      full_name: json['full_name'] ?? '',
      phone_number: json['phone_number'] ?? '',
      address: json['address'] ?? '',
      birth_date: json['birth_date'] ?? '',
      email_address: json['email_address'] ?? '',
      company_name: json['company_name'] ?? '',
      division_name: json['division_name'] ?? '',
      project_name: json['project_name'] ?? '',
    );
  }
}
