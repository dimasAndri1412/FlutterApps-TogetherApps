class locationsModels {
  final double latitude;
  final double longtitude;
  final double radius;
  final bool isValid;

  locationsModels({
    required this.latitude,
    required this.longtitude,
    required this.radius,
    this.isValid = true,
  });

  factory locationsModels.fromJson(Map<String, dynamic> json) {
    double? latitude = double.tryParse(json['latitude']?.toString() ?? '');
    double? longtitude = double.tryParse(json['longitude']?.toString() ?? '');
    double? radius = double.tryParse(json['radius']?.toString() ?? '');

    bool isValid = (latitude != null && longtitude != null && radius != null);

    return locationsModels(
      latitude: latitude ?? 0.0,
      longtitude: longtitude ?? 0.0,
      radius: radius ?? 0.0,
      isValid: isValid,
    );
  }
}
