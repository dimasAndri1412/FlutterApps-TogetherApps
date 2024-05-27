import 'package:absent_project/approvalls/cuti/DetailCutiUser.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

Future<void> DetailLemburUser(BuildContext context, int index, Function(int) approveLeave) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Overtime Detail'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Row(
                children: [
                  Text("Name  : ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Razu"),
                ],
              ),
              Row(
                children: [
                  Text("Date  : ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("19-02-2024"),
                ],
              ),
              Row(
                children: [
                  Text("Start hour : ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text( "16:00"),
                ],
              ),
              Row(
                children: [
                  Text("Until (hour) : ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text( "00.00"),
                ],
              ),
              Row(
                children: [
                  Text("Reason and Jobdesk: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("lalala")
                ],
              ),
              SizedBox(height: 20,),
              ElevatedButton.icon(
                onPressed: (){},
                icon: Icon(Icons.file_open),
                label: Text("Download Document"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 246, 178, 123),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold)
                ),
              ),
              ElevatedButton.icon(
                onPressed: ()async{
                  final result = await FilePicker.platform.pickFiles();
                  // if (result == null) return;
                  // final file = result.files.first;
                  // openFile(file);
                },
                icon: Icon(Icons.file_upload),
                label: Text("Upload Approval"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 124, 183, 230),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold)
                ),
              )
            ],
          )
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Approve', style: TextStyle(color: Colors.black.withOpacity(1.0))),
            onPressed: () {
              approveLeave(index);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void openFile(PlatformFile file){
  OpenFile.open(file.path!);
}