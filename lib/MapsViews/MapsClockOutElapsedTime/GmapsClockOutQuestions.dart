import 'package:absent_project/controller/AbsentController/ClockInController.dart';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionModel.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';

class gmapsClockOutQuestions extends StatefulWidget {
  const gmapsClockOutQuestions({super.key});

  @override
  State<gmapsClockOutQuestions> createState() => _gmapsClockOutQuestionsState();
}

class _gmapsClockOutQuestionsState extends State<gmapsClockOutQuestions> {
  final ClockInController _controller = ClockInController();
  List <QuestionModel> _questions = [];
  bool _isLoading = true;
  // Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  void _fetchQuestions() async {
    List<QuestionModel> questions = await _controller.show_question();
    setState(() {
      _questions = questions;
      initializeControllers(questions);  
      // for (var question in questions) {
      //   _controllers[question.idQuestion] = TextEditingController(
      //     text: question.idQuestion.toString(),
      //   );
      // }
      _isLoading = false;
    });
  }

  void initializeControllers(List<QuestionModel> questions) {
  for (var question in questions) {
    final questionId = question.idQuestion.toString();
    if (!answerController.containsKey(questionId)) {
      answerController[questionId] = TextEditingController();
      print('Controller initialized for questionId: $questionId');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(
              "Please insert question below : ",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _questions.length,
              itemBuilder: (context, index){
                final question = _questions[index];
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Text(
                        question.questionText,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 100,
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 8),
                        child: TextField(
                          // controller: _controllers[question.idQuestion],
                          controller: answerController[question.idQuestion.toString()],
                          maxLines: null,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            // labelText: '${question.idQuestion}',
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              )
        ],
      )
    );
  }
}