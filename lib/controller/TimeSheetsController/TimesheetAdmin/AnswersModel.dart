class AnswersModel {
  final String questionId;
  final String questionText;
  final String totalAnswers;

  AnswersModel({
    required this.questionId,
    required this.questionText,
    required this.totalAnswers,
  });

  factory AnswersModel.fromJson(Map<String, dynamic> json) {
    return AnswersModel(
      questionId: json['question_id'] as String,
      questionText: json['question_text'] as String,
      totalAnswers: json['total_answers'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'question_text': questionText,
      'total_answers': totalAnswers,
    };
  }
}
