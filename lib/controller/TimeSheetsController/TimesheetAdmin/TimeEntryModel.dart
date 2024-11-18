class TimeEntryModel{
  final String fullName;
  final DateTime? clockIn;
  final DateTime? clockOut;
  final String pictClockIn;
  final String pictClockOut;
  final String location;

  TimeEntryModel({
    required this.fullName,
    this.clockIn,
    this.clockOut,
    required this.pictClockIn,
    required this.pictClockOut,
    required this.location
  });

  factory TimeEntryModel.fromJson(Map<String, dynamic> json){
    return TimeEntryModel(
      fullName: json['full_name'] ?? " ", 
      clockIn: json['clock_in'] != null ? DateTime.parse(json['clock_in']) : null,
      clockOut: json['clock_out'] != null ? DateTime.parse(json['clock_out']) : null,
      pictClockIn: json['pict_clock_in'] ?? " ",
      pictClockOut: json['pict_clock_out'] ?? " ",
      location: json['location'] ?? " ",
    );
  }
}