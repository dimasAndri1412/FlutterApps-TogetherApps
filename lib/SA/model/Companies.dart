class Companies {
  int? id;
  String company_name;

  Companies({required this.id, required this.company_name});

  factory Companies.fromJson(Map<String, dynamic> json) {
    return Companies(
      id: json['id'] ?? 0,
      company_name: json['company_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "company_name": company_name,
    };
  }
}
