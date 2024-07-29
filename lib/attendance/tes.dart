import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';
import 'package:absent_project/attendance/FaceRecognitionScreen.dart'; // Import file yang berisi ImageWithFaces

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Detection App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? _imageFile;
  List<Face> _faces = [];

  Future<void> _pickAndDetectImage() async {
    final pickedFile = await pickImage();
    if (pickedFile != null) {
      final faces = await detectFaces(pickedFile);
      setState(() {
        _imageFile = pickedFile;
        _faces = faces;
      });
    }
  }

  Future<XFile?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    return photo;
  }

  Future<List<Face>> detectFaces(XFile imageFile) async {
    final FaceDetector faceDetector = GoogleMlKit.vision.faceDetector();
    final inputImage = InputImage.fromFilePath(imageFile.path);
    final List<Face> faces = await faceDetector.processImage(inputImage);
    return faces;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Face Detection')),
      body: Center(
        child: _imageFile == null
            ? Text('No image selected.')
            : ImageWithFaces(imageFile: _imageFile!, faces: _faces),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickAndDetectImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
