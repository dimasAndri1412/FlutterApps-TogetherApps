import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
// import 'package:absent_project/ChangesPasswordPage/CameraModel/Recognizer.dart';
import 'package:absent_project/attendance/FaceRegistration.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../attendance/ML/Recognizer.dart';
import '../controller/Keys.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../controller/data_controller.dart';
// import 'CameraModel/Recognition.dart';

class Changespasswordcamera extends StatefulWidget {
  // const Changespasswordcamera({super.key});

  @override
  State<Changespasswordcamera> createState() => _ChangespasswordcameraState();
}

class _ChangespasswordcameraState extends State<Changespasswordcamera> {
  File? _image;
  late ImagePicker _picker;
  String _errorMessage = '';
  late FaceDetector faceDetector;
  late Recognizer recognizer;
  Uint8List? croppedFaceBytes;
  List<Face> faces = [];
  var image;
  bool _isPicking = false;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    final options = FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
    faceDetector = FaceDetector(options: options);
    recognizer = Recognizer();
  }

  Future<void> _pickImage() async {
    if (_isPicking) return;
    setState(() {
      _isPicking = true;
    });

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          FaceImageController.text = pickedFile.path;
          // doFaceDetection();
        });
      } else {
        setState(() {
          _errorMessage = 'Tidak ada gambar yang dipilih.';
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    } finally {
      setState(() {
        _isPicking = false;
      });
    }
  }

  // Future<void> doFaceDetection() async {
  //   if (_image == null) return;
  //   InputImage inputImage = InputImage.fromFile(_image!);
  //   faces = await faceDetector.processImage(inputImage);
  //   if (faces.isNotEmpty) {
  //     image = await _image?.readAsBytes();
  //     image = await decodeImageFromList(image);
  //     for (Face face in faces) {
  //       final Rect boundingBox = face.boundingBox;
  //       num left = boundingBox.left < 0 ? 0 : boundingBox.left;
  //       num top = boundingBox.top < 0 ? 0 : boundingBox.top;
  //       num right = boundingBox.right > image.width ? image.width - 1 : boundingBox.right;
  //       num bottom = boundingBox.bottom > image.height ? image.height - 1 : boundingBox.bottom;
  //       num width = right - left;
  //       num height = bottom - top;

  //       final bytes = _image!.readAsBytesSync();
  //       img.Image? faceImg = img.decodeImage(bytes);
  //       final croppedFace = img.copyCrop(
  //         faceImg!, 
  //         x: left.toInt(), 
  //         y: top.toInt(), 
  //         width: width.toInt(), 
  //         height: height.toInt());
  //       croppedFaceBytes = Uint8List.fromList(img.encodeJpg(croppedFace));
  //       Recognition recognition = recognizer.recognize(croppedFace, boundingBox);

  //       // ubah embedding ke string biar bisa masuk db
  //       String embeddingString = jsonEncode(recognition.embeddings.join(','));
  //       EmbeddingController.text = embeddingString;

  //       // print('Recognition result: ${recognition.name}, ${recognition.distance}');
  //     }
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaceImageController.text.isEmpty
            ? Text('no images chosen')
            : FaceImageController.text.isEmpty
                ? Text('Mendeteksi wajah...')
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipOval(
                        child: Image(
                          image: FaceImageController.text.isNotEmpty ?
                          FileImage(File(FaceImageController.text)):
                          AssetImage("assets/images/reload.png") as ImageProvider,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Icon(Icons.check_circle, color: Colors.green),
                      ),
                    ],
                  ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: (){
            Get.offAll(() => FaceRegistration());
          },
          child: Text('Face Registration'),
        ),
        // ElevatedButton(onPressed: faceDetected ? ctr_data().update_pwd() : null, child: Text('Register Face')),
      ],
    );
  }
}

