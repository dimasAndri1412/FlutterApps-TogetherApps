import 'package:absent_project/controller/KPIQuestionsController/position/PositionModel.dart';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionController.dart';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionModel.dart';
import 'package:absent_project/menu/KPI%20Question/question/addQuestionDialog.dart';
import 'package:absent_project/menu/KPI%20Question/question/deleteQuestionDialog.dart';
import 'package:absent_project/menu/KPI%20Question/question/editQuestionDialog.dart';
import 'package:absent_project/menu/KPI%20Question/platform/platformList.dart';
import 'package:absent_project/menu/KPI%20Question/question/jobTypeList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detailkpiquestion extends StatefulWidget {
  final int positionId;
  final positionModel getPositionDetail;

  const Detailkpiquestion({required this.positionId, required this.getPositionDetail});

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
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Get.to(ApplicationBar(
        //         initialIndex: 3,
        //       ));
        //     },
        //     icon: Icon(
        //       Icons.arrow_back_ios_sharp,
        //       color: Colors.white,
        //     )),
        // title: 
        //   Text(
        //     "Sick Leave Approval",
        //     style: TextStyle(
        //         fontSize: 18,
        //         color: Colors.white,
        //         fontWeight: FontWeight.bold),
        //   ),
        // automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 147, 195, 234),
                  Color.fromARGB(255, 98, 171, 232),
                  Color.fromARGB(255, 123, 185, 235),
                ]),
              ),
            ),
            elevation: 0,
          ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 0, left: 20),
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25, left: 10, right: 5),
                    child: Image.asset(
                      'assets/images/clipboard.png',
                      width: 90,
                    )
                  ),
                  Text(
                    widget.getPositionDetail.positionName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                    softWrap: true, 
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Here you can create, modify,",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600]
                    ),
                  ),
                  Text(
                    "and delete job type and platform templates.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600]
                    ),
                  ),
                  SizedBox(height : 10)
                ],
              )
            ),
          ),
          Expanded(
            child:Container(
              margin: EdgeInsets.all(20),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(() => jobTypeList(
                        positionId: widget.positionId,
                        getPositionDetail: widget.getPositionDetail
                      ));
                    },
                    child: Container(
                      height: 160,
                      width: 150,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.all(20),
                              child: Image.asset(
                                'assets/images/distributed.png',
                                width: 90,
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 0),
                            child: Text("Job Type",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => platformList(
                        positionId: widget.positionId,
                        getPositionDetail: widget.getPositionDetail
                      ));
                    },
                    child: Container(
                      height: 160,
                      width: 150,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.all(20),
                              child: Image.asset(
                                'assets/images/platform.png',
                                width: 90,
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 0),
                            child: Text("Platform",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
        ],
      ),
      // floatingActionButton: showPlatform(positionId: widget.positionId,),
    );
  }
}