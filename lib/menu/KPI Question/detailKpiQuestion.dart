import 'package:absent_project/controller/KPIQuestionsController/question/QuestionController.dart';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionModel.dart';
import 'package:absent_project/menu/KPI%20Question/addQuestionDialog.dart';
import 'package:absent_project/menu/KPI%20Question/deleteQuestionDialog.dart';
import 'package:absent_project/menu/KPI%20Question/editQuestionDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detailkpiquestion extends StatefulWidget {
  final int positionId;

  const Detailkpiquestion({required this.positionId});

  @override
  State<Detailkpiquestion> createState() => _DetailkpiquestionState();
}

class _DetailkpiquestionState extends State<Detailkpiquestion> {
  final Questioncontroller _controller = Questioncontroller();
  List<QuestionModel> _questions = [];
  bool _isLoading = true;

  @override
  void initState(){
    super.initState();
    _fetchQuestions();
  }

  void _fetchQuestions() async {
    List<QuestionModel> questions = await _controller.getQuestions(widget.positionId);

    setState(() {
      _questions = questions;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 0),
            color: Colors.white,
            child: Center(
              child: Column(
                children : [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Image.asset(
                      'assets/images/clipboard.png',
                      width: 80,
                    )
                  ),
                  Text(
                    "Question list",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]
                    ),
                  ),
                  Text(
                    "Here you can create, modify and delete",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(
                    "question list templates.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600]
                    ),
                  ),
                ]
              )
            ),
          ),
          Expanded(
            child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                final question = _questions[index];
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            question.questionText,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return editQuestionDialog(
                                  questionId: question.idQuestion,
                                  questionText: question.questionText,
                                  positionId: question.idPosition,
                                );
                              }
                            ).then((_){
                              _fetchQuestions();
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context){
                                return deleteQuestionDialog(questionId: question.idQuestion, positionId: question.idPosition,);
                              }
                            ).then((_){
                              _fetchQuestions();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context, 
            builder: (BuildContext context) {
              return addQuestionDialog(positionId : widget.positionId);
            }
          ).then((_){
            _fetchQuestions();
          });
        },
        backgroundColor: Colors.orange[600],
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}