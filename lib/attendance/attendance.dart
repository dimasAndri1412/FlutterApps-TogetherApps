import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AttendanceScreen extends StatefulWidget {
  // final int userId;

  // AttendanceScreen(this.userId);
  AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _recordAttendance() async {
    if (_image == null) return;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.233.115.182/FlutterAPI/attendance/user/record_attendance.php'),
    );
    // request.fields['user_id'] = widget.userId.toString();
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    final data = jsonDecode(responseData);

    if (data['status'] == 'success') {
      // Attendance recorded
    } else {
      // Handle attendance recording error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Record Attendance')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _image == null ? Text('No image selected') : Image.file(_image!),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _pickImage, child: Text('Capture Image')),
              ElevatedButton(onPressed: _recordAttendance, child: Text('Record Attendance')),
            ],
          ),
        ),
      )
    );
  }
}
