class WeeklyModel {
  final String day;
  final String totalHours;

  WeeklyModel({required this.day, required this.totalHours});

  factory WeeklyModel.fromJson(Map<String, dynamic> json) {
    return WeeklyModel(
      day: json['day'],
      totalHours: json['total_hours'],
    );
  }
}
