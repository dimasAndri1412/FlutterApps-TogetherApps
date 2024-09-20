class QuestionModel {
  final int idQuestion;
  final int idPosition;
  final String questionText;

  QuestionModel({required this.idPosition, required this.idQuestion, required this.questionText});

  factory QuestionModel.fromJson(Map<String, dynamic> json){
    return QuestionModel(
      idPosition: int.parse(json['id_position'].toString()), 
      idQuestion: int.parse(json['id_question'].toString()), 
      questionText: json['question_text']
    );
  }
}