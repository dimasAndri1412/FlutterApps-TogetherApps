import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:absent_project/approvalls/cuti/GeneratePDF_MSDO.dart';
import 'package:http/http.dart' as http;
import '../../../controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeaveModel.dart';

class ConfirmationDialog extends StatefulWidget {
  final AdminApprovalPaidLeaveModel getUserDetail;
  const ConfirmationDialog({super.key, required this.getUserDetail});

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {

  updateApproved() async {
    final response = await http.post(
      Uri.parse("http://10.233.77.55/FlutterAPI/approvals/admin/paid_leave/update_approved.php"),
      body: {
        "reqNo": widget.getUserDetail.reqNo
      },
    );
    if (response.statusCode == 200){
      return true;
    }
    return false;
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
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
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
                    Icons.warning_rounded,
                    color: Colors.white,
                    size: 80.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Are you Sure?',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Are you sure to approve this request?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 24.0),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final pdf = await PDFGenerator_MSDO(getUserDetail:  widget.getUserDetail,).GeneratePDF();
                    await Printing.layoutPdf(
                        onLayout: (format) => pdf);
                    setState(() {
                      updateApproved();
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.print, color: Colors.white,),
                      SizedBox(width: 10,),
                      Text('Approve & Print Document',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    child: Text("Cancel",
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