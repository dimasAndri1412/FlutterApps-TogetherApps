class Positions {
  String position_name;

  Positions({required this.position_name});

  Map<String, dynamic> toJson() {
    return {
      "position_name": position_name,
    };
  }
}
