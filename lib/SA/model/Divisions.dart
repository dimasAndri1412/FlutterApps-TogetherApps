class Divisions {
  int? id;
  String division_name;

  Divisions({
    required this.id,
    required this.division_name,
  });

  Map<String, dynamic> toJson() {
    return {
      "division_name": division_name,
    };
  }

  factory Divisions.fromJson(Map<String, dynamic> json){
    return Divisions(
      id: json['id'] ?? 0,
      division_name: json['division_name'] ?? ""
    );
  }
}
