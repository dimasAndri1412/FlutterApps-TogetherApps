class Positions {
  int? id;
  String position_name;

  Positions({required this.id, required this.position_name});

  factory Positions.fromJson(Map<String, dynamic> json) {
    return Positions(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      position_name: json['position_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "position_id": id,
    };
  }
}
