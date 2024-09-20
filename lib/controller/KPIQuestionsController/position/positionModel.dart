class positionModel {
  final int idPosition;
  final String positionName;

  positionModel({required this.idPosition, required this.positionName});

  factory positionModel.fromJson(Map<String, dynamic> json) {
    return positionModel(
      idPosition: int.parse(json['id_position'].toString()),
      positionName: json['position_name'],
    );
  }
}
