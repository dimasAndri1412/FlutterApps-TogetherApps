class Divisions {
  String division_name;

  Divisions({
    required this.division_name,
  });

  Map<String, dynamic> toJson() {
    return {
      "division_name": division_name,
    };
  }
}
