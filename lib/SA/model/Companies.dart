class Companies {
  String company_name;

  Companies({
    required this.company_name
  });

  Map<String, dynamic> toJson() {
    return {
      "company_name": company_name,
    };
  }
}
