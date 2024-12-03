import 'package:absent_project/controller/KPIQuestionsController/platform/platformController.dart';
import 'package:absent_project/controller/KPIQuestionsController/platform/platformModel.dart';
import 'package:absent_project/controller/KPIQuestionsController/position/PositionModel.dart';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionController.dart';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionModel.dart';
import 'package:absent_project/menu/KPI%20Question/platform/addPlatformDialog.dart';
import 'package:absent_project/menu/KPI%20Question/platform/deletePlatformDialog.dart';
import 'package:absent_project/menu/KPI%20Question/platform/editPlatformDialog.dart';
import 'package:absent_project/menu/KPI%20Question/question/addQuestionDialog.dart';
import 'package:absent_project/menu/KPI%20Question/question/deleteQuestionDialog.dart';
import 'package:absent_project/menu/KPI%20Question/question/editQuestionDialog.dart';
import 'package:absent_project/menu/KPI%20Question/platform/platformList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class platformList extends StatefulWidget {
  final int positionId;
  final positionModel getPositionDetail;

  const platformList({required this.positionId, required this.getPositionDetail});

  @override
  State<platformList> createState() => _platformListState();
}

class _platformListState extends State<platformList> {
  final platformController _controller = platformController();
  // List<PlatformModel> _platforms = [];
  bool _isLoading = true;

  @override
  void initState(){
    super.initState();
    _fetchPlatforms();
  }

  void _fetchPlatforms() async {
    await _controller.fetchPlatform(widget.positionId);
    setState(() {
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
                      'assets/images/platform.png',
                      width: 80,
                    )
                  ),
                  Text(
                    "Platform List",
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
                    "platform list templates.",
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
                ? const Center(child: CircularProgressIndicator())
                : Obx(
                    () => ListView.builder(
                      itemCount: _controller.platforms.length,
                      itemBuilder: (context, index) {
                        final platform = _controller.platforms[index];
                        return Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    platform.platformName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    showDialog(
                                      context: context, 
                                      builder: (BuildContext context) {
                                        return editPlatformDialog(
                                          platformId : platform.idPlatform,
                                          platformName: platform.platformName,
                                          positionId: platform.idPosition,
                                        );
                                      }
                                    ).then((_){
                                      _fetchPlatforms();
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context, 
                                      builder: (BuildContext context){
                                        return deletePlatformDialog(
                                          platformId: platform.idPlatform, 
                                          positionId: platform.idPosition,
                                        );
                                      }
                                    ).then((_){
                                      _fetchPlatforms();
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context, 
            builder: (BuildContext context) {
              return addPlatformDialog(positionId : widget.positionId);
            }
          ).then((_){
            _fetchPlatforms();
          });
        },
        backgroundColor: Colors.orange[600],
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}