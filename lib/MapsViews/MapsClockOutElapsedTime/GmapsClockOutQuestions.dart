import 'package:absent_project/controller/AbsentController/ClockInController.dart';
import 'package:absent_project/controller/KPIQuestionsController/platform/platformModel.dart';
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
  List<QuestionModel> _questions = [];
  List<PlatformModel> _platforms = [];
  bool _isLoading = true;

  // List<int?> selectedQuestions = [null]; 
  // List<int?> selectedPlatforms = [null]; 
  // List<TextEditingController> answerControllers = [TextEditingController()]; 

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
    _fetchPlatform();

    selectedQuestionControllers.clear();
    selectedPlatformControllers.clear();
    answersControllers.clear();

    _addQuestionField();
  }

  void _fetchQuestions() async {
    List<QuestionModel> questions = await _controller.show_question();
    setState(() {
      _questions = questions;
      _isLoading = false;
    });
  }

  void _fetchPlatform() async {
    List<PlatformModel>? platforms = await _controller.show_platform();
    if (platforms != null) {
      setState(() {
        _platforms = platforms;
      });
    }
  }

  void _addQuestionField() {
    setState(() {
      selectedQuestionControllers.add(TextEditingController());
      selectedPlatformControllers.add(TextEditingController());
      answersControllers.add(TextEditingController()); 
    });
  }

  @override
  void dispose() {
    for (var controller in selectedQuestionControllers) {
      controller.dispose();
    }
    for (var controller in selectedPlatformControllers) {
      controller.dispose();
    }
    for (var controller in answersControllers) {
      controller.dispose();
    }

    selectedQuestionControllers.clear();
    selectedPlatformControllers.clear();
    answersControllers.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What did you do today?",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),

          for (int i = 0; i < selectedQuestionControllers.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DropdownButton<int>(
                        hint: Text("Select a question"),
                        value:  int.tryParse(selectedQuestionControllers[i].text),
                        items: _questions.map((question) {
                          return DropdownMenuItem<int>(
                            value: question.idQuestion,
                            child: Text(question.questionText),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            // selectedQuestions[i] = value;
                            // selectedPlatforms[i] = null;
                            selectedQuestionControllers[i].text = value.toString();
                            selectedPlatformControllers[i].clear(); 
                          });
                          print("Selected Question ID: $value"); 
                        },
                      ),
                      SizedBox(width: 10),

                      if (selectedQuestionControllers[i].text.isNotEmpty) ...[
                        DropdownButton<int>(
                          hint: Text("Select a platform"),
                          value: int.tryParse(selectedPlatformControllers[i].text),
                          items: _platforms.map((platform) {
                            return DropdownMenuItem<int>(
                              value: platform.idPlatform,
                              child: Text(platform.platformName),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              // selectedPlatforms[i] = value;
                              selectedPlatformControllers[i].text = value.toString();
                            });
                            print("Selected platform ID: $value");
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ],
                  ),
                  if (selectedPlatformControllers[i].text.isNotEmpty)
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          controller: answersControllers[i],
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Detail",
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

          IconButton(
            onPressed: _addQuestionField,
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
