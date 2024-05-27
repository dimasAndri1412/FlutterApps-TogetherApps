import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

Future<void> DetailCutiUser(BuildContext context, int index, Function(int) approveLeave) {
  String fileUrl = 'https://example.com/path/to/your/file.pdf'; // Ensure this URL is correct
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Leave Detail'),
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
                  Text("19-02-2024 s.d 20-02-2024"),
                ],
              ),
              Row(
                children: [
                  Text("Total of Days : ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("2"),
                ],
              ),
              Row(
                children: [
                  Text("Reason : ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Pulang kampung"),
                ],
              ),
              SizedBox(height: 20,),
              ElevatedButton.icon(
                onPressed: () {
                  openFile(
                    url: fileUrl,
                    fileName: 'Leave Form - Name.pdf'
                  );
                },
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
                icon: Icon(Icons.file_upload),
                label: Text("Upload Approval"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 124, 183, 230),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold)
                ),
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result == null) return;
                    final file = result.files.first;
                    print('Name: ${file.name}');
                    print('Bytes: ${file.bytes}');
                    print('Size: ${file.size}');
                    print('Picked file: ${file.path}');
                  
                    final newFile = await saveFile(file);

                    print('from path : ${file.path!}');
                    print('to path : ${newFile.path}');
                },
              ),
            ],
          ),
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

Future<void> openFile({required String url, required String fileName}) async {
  try {
    final file = await downloadFile(url, fileName);
    if (file == null) return;
    OpenFile.open(file.path);
  } catch (e) {
    print("Error opening file: $e");
  }
}

Future<File?> downloadFile(String url, String fileName) async {
  try {
    // Check and request storage permissions
    if (await Permission.storage.request().isGranted) {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/$fileName');

      // Log the download start
      print('Starting download from $url');

      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      if (response.statusCode == 200) {
        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();

        // Log successful download
        print('File downloaded successfully to ${file.path}');
        return file;
      } else {
        print('Failed to download file. Status code: ${response.statusCode}');
        return null;
      }
    } else {
      print('Storage permission denied.');
      return null;
    }
  } catch (e) {
    print("Error downloading file: $e");
    return null;
  }
}


Future<File> saveFile (PlatformFile file) async{
  final appStorage = await getApplicationDocumentsDirectory();
  final newFile = File('${appStorage.path}/${file.name}');

  return File(file.path!).copy(newFile.path);
}