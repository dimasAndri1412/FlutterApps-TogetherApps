import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../controller/Keys.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../controller/data_controller.dart';

class Changespasswordcamera extends StatefulWidget {
  // const Changespasswordcamera({super.key});

  @override
  State<Changespasswordcamera> createState() => _ChangespasswordcameraState();
}

class _ChangespasswordcameraState extends State<Changespasswordcamera> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String _errorMessage = '';

  bool faceDetected = false;
  Face? detectedFace;

  
   Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        FaceImageController.text = pickedFile.path;
      });
    } else {
      setState(() {
        _errorMessage = '';
      });
      detectFace(_image!);
    }
  }

  Future<void> detectFace(File image) async {
    final inputImage = InputImage.fromFile(image);
    final faceDetector = GoogleMlKit.vision.faceDetector();
    final List<Face> faces = await faceDetector.processImage(inputImage);

    if (faces.isNotEmpty) {
        setState(() {
          faceDetected = true;
          detectedFace = faces.first;
        });
    } else {
        setState(() {
          faceDetected = false;
          detectedFace = null;
        });
    }
  }

  void validateAndSubmit() {
    if (_image != null) {
      // Lanjutkan dengan proses selanjutnya jika gambar sudah dipilih
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gambar sudah dipilih.')));
    } else {
      setState(() {
        _errorMessage = 'Gambar tidak boleh kosong!';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _image == null
          ? Text('No image selected')
          : Stack(
              alignment: Alignment.center,
              children: [
                ClipOval(
                  child: Image.file(
                    _image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Icon(Icons.check_circle, color: Colors.green,)
                ),
              ],
            ),
            SizedBox(height: 20),
            faceDetected ? Text('Face detected') : Text('No face detected'),
            SizedBox(height: 20),
            SizedBox(height: 10,),
        ElevatedButton(
          onPressed: _pickImage, 
          child: Text('Capture Face')
        ),
        // ElevatedButton(onPressed: faceDetected ? ctr_data().update_pwd() : null, child: Text('Register Face')),
      ]
    );
  }
}