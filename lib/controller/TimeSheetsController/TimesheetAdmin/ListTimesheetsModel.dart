class ListTimesheetsModel{
  final DateTime? clockIn;
  final String clockInID;
  final String clockOutID;
  final DateTime? clockOut;
  final String? elapsedTime;
  final String? fullName;
  final String imagePath;
  final String pictClockIn;
  final String pictClockOut;
  final String? shift;
  final String userId;

  ListTimesheetsModel({
    this.clockIn,
    required this.clockInID,
    required this.clockOutID,
    this.clockOut,
    this.elapsedTime,
    this.fullName,
    required this.imagePath,
    required this.pictClockIn,
    required this.pictClockOut,
    this.shift,
    required this.userId,
  });

  factory ListTimesheetsModel.fromJson(Map<String, dynamic> json){
    return ListTimesheetsModel(
      clockIn: json['clock_in'] != null ? DateTime.parse(json['clock_in']) : null,
      clockInID: json['clock_in_id'] ?? " ",
      clockOutID: json['clock_out_id'] ?? " ",
      clockOut: json['clock_out'] != null ? DateTime.parse(json['clock_out']) : null,
      elapsedTime: json['elapsed_time'] ?? " ",
      fullName: json['full_name'] ?? " ",
      imagePath: json['image_path'] ?? " ",
      pictClockIn: json['pict_clock_in'] ?? " ",
      pictClockOut: json['pict_clock_out'] ?? " ",
      shift: json['shift'] ?? " ",
      userId: json['user_id'] ?? " "
    );
  }
}

// "full_name": "Rara Zahra Urava",
// "clock_in_id": "65",
// "clock_in": "2024-10-04 16:00:39",
// "clock_out": "2024-10-04 16:02:45",
// "elapsed_time": "00:02:06",
// "image_path": "http://192.168.100.84/img/face_data/sunoo.jpg"