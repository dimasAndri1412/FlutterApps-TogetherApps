class MonthlyTimesheetModel{
  final DateTime? clockIn;
  final String? location;
  final String? shift;
  final DateTime? clockOut;
  final String? elapsedTime;
  final List<String>? questionText;
  final List<String>? answerText;
  final String? clockOutId;
  final String? grup;

  MonthlyTimesheetModel({
    this.clockIn,
    this.location,
    this.shift,
    this.clockOut,
    this.clockOutId,
    this.elapsedTime,
    this.questionText,
    this.answerText,
    this.grup
  });

  factory MonthlyTimesheetModel.fromJson(Map<String, dynamic> json){
    return MonthlyTimesheetModel(
      clockIn: json['clock_in'] != null ? DateTime.parse(json['clock_in']) : null,
      location: json['location'] as String?,
      shift: json['shift'] as String?,
      clockOut: json['clock_out'] != null ? DateTime.parse(json['clock_in']) : null,
      clockOutId: json['clock_out_id'] as String?,
      elapsedTime: json['elapsed_time'] as String?,
      questionText: json['questions'] != null ? List<String>.from(json['questions']) : null,
      answerText: json['answers'] != null ? List<String>.from(json['answers']) : null,
      grup: json['grup'] as String?,
    );
  }
}


//  "clock_in": "2024-09-23 10:53:12",
//   "location": "bri",
//   "shift": "non",
//   "clock_out": "2024-09-23 14:17:12",
//   "elapsed_time": "03:24:00",
//   "question_text": "What job are you running today?",
//   "answer_text": "Ya"