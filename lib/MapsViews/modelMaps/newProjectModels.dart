class newProjecModels {
  String projectName;
  String locationName;
  double? latitudeName;
  double? longtitudeName;

  newProjecModels({
    required this.projectName,
    required this.locationName,
    required this.latitudeName,
    required this.longtitudeName
  });

  factory newProjecModels.fromJson(Map<String, dynamic> json) {
    return newProjecModels(
        projectName: json['project_name'],
        locationName: json['location_name'],
        latitudeName: json['latitude'],
        longtitudeName: json['longtitude']
    );
  }

  static List<newProjecModels> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => newProjecModels.fromJson(json)).toList();
  }
}