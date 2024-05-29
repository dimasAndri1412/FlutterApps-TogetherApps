import 'package:flutter/material.dart';

class DetailCutiUser extends StatefulWidget {
  const DetailCutiUser({super.key});

  @override
  State<DetailCutiUser> createState() => _DetailCutiUserState();
}

class _DetailCutiUserState extends State<DetailCutiUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("halo"),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';

// Future<void> DetailCutiUser(BuildContext context, int index, Function(int) approveLeave) {
//   String fileUrl = 'https://example.com/path/to/your/file.pdf'; // Ensure this URL is correct
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Colors.white,
//         title: Center(
//           child: Text('Paid Leave Detail'),
//         ),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: [
//               Row(
//                 children: [
//                   Text("Name  : ", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("Razu"),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text("Position  : ", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("IT Data Operator"),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text("Department : ", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text(""),
//                 ],
//               ),
//               SizedBox(height: 20,),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(width: 0.5, color: Colors.black),
//                   borderRadius: BorderRadius.circular(10)
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Reason',
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           Row(
//             children: [
//               ElevatedButton.icon(
//                 icon: Icon(Icons.close),
//                 label: Text("Reject"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   foregroundColor: Colors.white,
//                   textStyle: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold)
//                 ),
//                 onPressed: (){},
//               ),
//               SizedBox(width: 10),
//               ElevatedButton.icon(
//                 icon: Icon(Icons.check),
//                 label: Text("Approve"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   foregroundColor: Colors.white,
//                   textStyle: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold)
//                 ),
//                 onPressed: () async {
                 
//                 },
//               ),
//             ],
//           )
//         ],
//       );
//     },
//   );
// }

// Future<void> openFile({required String url, required String fileName}) async {
//   try {
//     final file = await downloadFile(url, fileName);
//     if (file == null) return;
//     OpenFile.open(file.path);
//   } catch (e) {
//     print("Error opening file: $e");
//   }
// }

// Future<File?> downloadFile(String url, String fileName) async {
//   try {
//     // Check and request storage permissions
//     if (await Permission.storage.request().isGranted) {
//       final appStorage = await getApplicationDocumentsDirectory();
//       final file = File('${appStorage.path}/$fileName');

//       // Log the download start
//       print('Starting download from $url');

//       final response = await Dio().get(
//         url,
//         options: Options(
//           responseType: ResponseType.bytes,
//           followRedirects: false,
//         ),
//       );

//       if (response.statusCode == 200) {
//         final raf = file.openSync(mode: FileMode.write);
//         raf.writeFromSync(response.data);
//         await raf.close();

//         // Log successful download
//         print('File downloaded successfully to ${file.path}');
//         return file;
//       } else {
//         print('Failed to download file. Status code: ${response.statusCode}');
//         return null;
//       }
//     } else {
//       print('Storage permission denied.');
//       return null;
//     }
//   } catch (e) {
//     print("Error downloading file: $e");
//     return null;
//   }
// }


// Future<File> saveFile (PlatformFile file) async{
//   final appStorage = await getApplicationDocumentsDirectory();
//   final newFile = File('${appStorage.path}/${file.name}');

//   return File(file.path!).copy(newFile.path);
// }