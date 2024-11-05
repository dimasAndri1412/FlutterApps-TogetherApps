import 'package:absent_project/controller/KPIQuestionsController/position/PositionController.dart';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';

class editPositionDialog extends StatefulWidget {
  final int positionId;
  final String positionName;

  const editPositionDialog({required this.positionId, required this.positionName});

  @override
  State<editPositionDialog> createState() => _editPositionDialogState();
}

class _editPositionDialogState extends State<editPositionDialog> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = widget.positionName;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                color: Colors.blue[700],
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
                    Icons.update,
                    color: Colors.white,
                    size: 70.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Update Position',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'id position ${widget.positionId}',
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
                      controller: textController,
                      maxLines: null,
                      minLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // labelText: '${widget.questionText}',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {
                      // Questioncontroller questionController = Questioncontroller();
                      // questionController.editQuestion(widget.questionId, textController.text);
                      PositionController positionController = PositionController();
                      positionController.editPosition(widget.positionId, textController.text);

                      positionName.clear();
                      Navigator.pop(context);
                    }, 
                    child: Text("Update Question",
                      style: TextStyle(
                        color: Colors.blue[400]
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue, width: 2.0)

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