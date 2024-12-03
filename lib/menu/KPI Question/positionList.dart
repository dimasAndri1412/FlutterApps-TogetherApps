import 'package:absent_project/controller/KPIQuestionsController/position/PositionController.dart';
import 'package:absent_project/menu/KPI%20Question/addPositionDialog.dart';
import 'package:absent_project/menu/KPI%20Question/deletePositionDialog.dart';
import 'package:absent_project/menu/KPI%20Question/detailKpi.dart';
import 'package:absent_project/menu/KPI%20Question/editPositionDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class kpiQuestion extends StatefulWidget {
  const kpiQuestion({super.key});

  @override
  State<kpiQuestion> createState() => _kpiQuestionState();
}

class _kpiQuestionState extends State<kpiQuestion> {
  final PositionController positionController = PositionController();

  void initState() {
    super.initState();
    positionController.fetchPositions();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 147, 195, 234),
                      Color.fromARGB(255, 98, 171, 232),
                      Color.fromARGB(255, 123, 185, 235),
                    ]
                  ),
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(34), bottomRight: Radius.circular(34) )
                ),
              ),
              Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0,10,),
                      blurRadius: 50,
                      color: Color.fromARGB(255, 246, 178, 198).withOpacity(0.23),
                    )
                  ]
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              )
            )
            ],
          ),
          Expanded(
            child: Obx(() {
              if (positionController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (positionController.errorMessage.value.isNotEmpty) {
                return Center(child: Text(positionController.errorMessage.value));
              } else {
                return ListView.builder(
                  itemCount: positionController.positions.length,
                  itemBuilder: (context, index) {
                    final position = positionController.positions[index];
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                  return editPositionDialog(
                                    positionId: position.idPosition,
                                    positionName: position.positionName,
                                  );
                                }
                              ).then((_){
                                positionController.fetchPositions();
                              });
                            },
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                            borderRadius: BorderRadius.circular(12),
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                  return deletePositionDialog(
                                    positionId: position.idPosition,
                                  );
                                }
                              ).then((_){
                                positionController.fetchPositions();
                                Get.snackbar('Success', 'Position deleted successfully');
                              }); 
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => Detailkpiquestion(
                            positionId: position.idPosition,
                            getPositionDetail: position,
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10, right: 25, left: 25, bottom: 10),
                          width: 350,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 147, 195, 234),
                                blurRadius: 15,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              position.positionName, 
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context, 
            builder: (BuildContext context) {
              return addPositionDialog();
            }
          ).then((_){
            positionController.fetchPositions();
            Get.snackbar('Success', 'Position added successfully');
          });
        },
        backgroundColor: Colors.orange[600],
        child: const Icon(Icons.add, color: Colors.white,),
      ), 
    );
  }
}