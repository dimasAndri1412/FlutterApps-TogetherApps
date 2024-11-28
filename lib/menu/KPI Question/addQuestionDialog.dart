import 'package:absent_project/controller/KPIQuestionsController/position/PositionController.dart';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/KPIQuestionsController/question/QuestionModel.dart';

class addQuestionDialog extends StatefulWidget {
  final int positionId;

  const addQuestionDialog({required this.positionId});

  @override
  State<addQuestionDialog> createState() => _addQuestionDialogState();
}

class _addQuestionDialogState extends State<addQuestionDialog> {
  final Questioncontroller _controller = Questioncontroller();
  List<QuestionModel> _questions = [];
  bool _isLoading = true;

  void _fetchQuestions() async {
    List<QuestionModel> questions = await _controller.getQuestions(widget.positionId);

    setState(() {
      _questions = questions;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // String positionName = 'uknown';
    // var matchedPosition = positionController.positions
    //   .firstWhereOrNull((position) => position.idPosition == widget.positionId);

    // if (matchedPosition != null) {
    //   positionName = matchedPosition.positionName;
    // }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        // padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 400,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.orange[600],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: 
                  Icon(
                    Icons.question_answer_rounded,
                    color: Colors.white,
                    size: 70.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Add Question',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'id role ${widget.positionId}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 14.0),
            Column(
              children: [
                Container(
                  height: 100,
                  width: 270,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 8),
                    child: TextField(
                      controller: questionText,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter the question here',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {
                      Questioncontroller questionController = Questioncontroller(); 
                      questionController.addQuestion(widget.positionId);

                      questionText.clear();
                      _fetchQuestions();
                      Navigator.pop(context);
                    }, 
                    child: Text("Add Question",
                      style: TextStyle(
                        color: Colors.orange[400]
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.orange, width: 2.0)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}