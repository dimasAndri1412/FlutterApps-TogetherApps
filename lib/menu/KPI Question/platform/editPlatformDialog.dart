import 'package:absent_project/controller/KPIQuestionsController/platform/platformController.dart';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionController.dart';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionModel.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';

class editPlatformDialog extends StatefulWidget {
  final int platformId;
  final String platformName;
  final int positionId;

  const editPlatformDialog({required this.platformId, required this.platformName, required this.positionId});

  @override
  State<editPlatformDialog> createState() => _editPlatformDialogState();
}

class _editPlatformDialogState extends State<editPlatformDialog> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = widget.platformName;
    _fetchPlatforms();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    super.dispose();
  }

  // final Questioncontroller _controller = Questioncontroller();
  // List<QuestionModel> _questions = [];
  // bool _isLoading = true;
  // void _fetchQuestions() async {
  //   List<QuestionModel> questions = await _controller.getQuestions(widget.positionId);

  //   setState(() {
  //     _questions = questions;
  //     _isLoading = false;
  //   });
  // }

  final platformController _controller = platformController();
  // List<PlatformModel> _platforms = [];
  bool _isLoading = true;
  void _fetchPlatforms() async {
    await _controller.fetchPlatform(widget.positionId);
    setState(() {
      _isLoading = false;
    });
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
              'Update Platform',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'id platform ${widget.platformId}',
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
                        // labelText: '${widget.platformName}',
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
                      _controller.editPlatform(widget.platformId, textController.text);

                      platformName.clear();
                      _fetchPlatforms();
                      Navigator.pop(context);
                    }, 
                    child: Text("Update Platform",
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