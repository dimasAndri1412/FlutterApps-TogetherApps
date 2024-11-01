class PlatformModel {
  final int idPlatform;
  final int idPosition;
  final String platformName;

  PlatformModel({required this.idPosition, required this.idPlatform, required this.platformName});

  factory PlatformModel.fromJson(Map<String, dynamic> json){
    return PlatformModel(
      idPosition: int.parse(json['position_id'].toString()), 
      idPlatform: int.parse(json['id_platform'].toString()), 
      platformName: json['platform_name'] as String
    );
  }
}