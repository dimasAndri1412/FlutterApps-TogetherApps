import 'package:absent_project/controller/KPIQuestionsController/platform/platformController.dart';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionController.dart';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionModel.dart';
import 'package:flutter/material.dart';

class deletePlatformDialog extends StatefulWidget {
  final int platformId;
  final int positionId;
  const deletePlatformDialog({required this.platformId, required this.positionId});

  @override
  State<deletePlatformDialog> createState() => _deletePlatformDialogState();
}

class _deletePlatformDialogState extends State<deletePlatformDialog> {
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
                color: Colors.red,
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
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 70.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Are you sure?',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'delete this platform? ${widget.platformId} ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 14.0),
            Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {
                     _controller.deletePlatform(widget.platformId);

                      Navigator.pop(context);
                      _fetchPlatforms();
                    }, 
                    child: Text("Delete Question",
                      style: TextStyle(
                        color: Colors.red
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red, width: 2.0)

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