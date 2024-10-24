import 'dart:typed_data';
import 'dart:math';
import 'dart:io';
import 'package:absent_project/ChangesPasswordPage/CameraModel/Recognition.dart';
import 'package:absent_project/ChangesPasswordPage/CameraModel/Recognizer.dart';
import 'package:absent_project/MapsViews/MapsClockOutElapsedTime/GmapsClockOutPages.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart'; // Sesuaikan impor ini jika menggunakan ML Kit Commons
import 'package:provider/provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:absent_project/MapsViews/MapsConfirmLocationPages/GmapsConfirmHeaders.dart';
import 'package:absent_project/MapsViews/MapsConfirmLocationPages/GmapsConfirmPages.dart';

import '../controller/AbsentController/ClockInState.dart'; // Import Recognizer class

class Camera extends StatefulWidget {
    @override
    _CameraState createState() => _CameraState();
  }

  class _CameraState extends State<Camera> {
    late CameraController cameraController;
    late List<CameraDescription> cameras;
    bool isInitialized = false;
    late List<Recognition> recognitions = [];
    late Size size;
    //TODO declare face detector
    late FaceDetector faceDetector;
    CameraLensDirection camDirec = CameraLensDirection.front;

    //TODO declare face recognizer
    late Recognizer recognizer;

    @override
    void initState() {
      super.initState();
      _initializeCamera();

      faceDetector = FaceDetector(
        options: FaceDetectorOptions(
          enableContours: true,
          enableClassification: true,
        ),
      );
      recognizer = Recognizer(); // Pastikan inisialisasi ini benar
    }

    Future<void> _initializeCamera() async {
      cameras = await availableCameras();
      cameraController = CameraController(cameras[1], ResolutionPreset.high, imageFormatGroup: Platform.isAndroid
      ? ImageFormatGroup.nv21 // for Android
      : ImageFormatGroup.bgra8888,enableAudio: false);

      await cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        cameraController.startImageStream((image) => {
          if (!isInitialized) {
            isInitialized = true, frame = image, doFaceDetectionOnFrame()
            }
        });
      });   
    }

    img.Image? image;
    // bool register = false;
  // TODO perform Face Recognition
  performFaceRecognition(List<Face> faces) async {
    recognitions.clear();

    //TODO convert CameraImage to Image and rotate it so that our frame will be in a portrait
    image = Platform.isIOS?_convertBGRA8888ToImage(frame!) as img.Image?:_convertNV21(frame!);
    image =img.copyRotate(image!, angle: camDirec == CameraLensDirection.front?270:90);

    for (Face face in faces) {
      Rect faceRect = face.boundingBox;
      //TODO crop face
      img.Image croppedFace = img.copyCrop(image!, x:faceRect.left.toInt(),y:faceRect.top.toInt(),width:faceRect.width.toInt(),height:faceRect.height.toInt());

      //TODO pass cropped face to face recognition model
      Recognition recognition = recognizer.recognize(croppedFace!, faceRect);
      if(recognition.distance>1.0){
        recognition.name = "Unknown";
      }
      recognitions.add(recognition);

    }

    setState(() {
      isInitialized  = false;
      _scanResults = recognitions;
    });

  }

    @override
    void dispose() {
      cameraController.dispose();
      super.dispose();
    }

    dynamic _scanResults;
    CameraImage? frame;
    doFaceDetectionOnFrame() async {
      //TODO convert frame into InputImage format
      if (faceDetector == null) {
        print("FaceDetector belum diinisialisasi");
        return;
      }

      print("Format frame: ${frame!.format.raw}");
      print("Plane bytes length: ${frame!.planes.first.bytes.length}");
      if (frame == null) {
        print("Frame tidak ditemukan");
        return;
      }
      print('dfd');
      try {
        InputImage? inputImage = getInputImage();
        if (inputImage == null) {
          print("InputImage tidak valid");
          return;
        }
        List<Face> faces = await faceDetector.processImage(inputImage);
        print("fl="+faces.length.toString());
        performFaceRecognition(faces);
      } catch (e) {
        print("Error dalam deteksi wajah: $e");
      }
      // InputImage? inputImage = getInputImage();
      // //TODO pass InputImage to face detection model and detect faces
      // List<Face> faces = await faceDetector.processImage(inputImage!);

      // print("fl="+faces.length.toString());
      // //TODO perform face recognition on detected faces
      // performFaceRecognition(faces);
      // setState(() {
      //   _scanResults = faces;
      //   isBusy = false;
      // });
    }

    static var IOS_BYTES_OFFSET = 28;

    static img.Image _convertBGRA8888ToImage(CameraImage cameraImage) {
      final plane = cameraImage.planes[0];

      return img.Image.fromBytes(
        width: cameraImage.width,
        height: cameraImage.height,
        bytes: plane.bytes.buffer,
        rowStride: plane.bytesPerRow,
        bytesOffset: IOS_BYTES_OFFSET,
        order: img.ChannelOrder.bgra,
      );
    }

    static img.Image _convertNV21(CameraImage image) {
      final width = image.width.toInt();
      final height = image.height.toInt();

      Uint8List yuv420sp = image.planes[0].bytes;

      final outImg = img.Image(height:height, width:width);
      final int frameSize = width * height;

      for (int j = 0, yp = 0; j < height; j++) {
        int uvp = frameSize + (j >> 1) * width, u = 0, v = 0;
        for (int i = 0; i < width; i++, yp++) {
          int y = (0xff & yuv420sp[yp]) - 16;
          if (y < 0) y = 0;
          if ((i & 1) == 0) {
            v = (0xff & yuv420sp[uvp++]) - 128;
            u = (0xff & yuv420sp[uvp++]) - 128;
          }
          int y1192 = 1192 * y;
          int r = (y1192 + 1634 * v);
          int g = (y1192 - 833 * v - 400 * u);
          int b = (y1192 + 2066 * u);

          if (r < 0)
            r = 0;
          else if (r > 262143) r = 262143;
          if (g < 0)
            g = 0;
          else if (g > 262143) g = 262143;
          if (b < 0)
            b = 0;
          else if (b > 262143) b = 262143;

          // I don't know how these r, g, b values are defined, I'm just copying what you had bellow and
          // getting their 8-bit values.
          outImg.setPixelRgb(i, j, ((r << 6) & 0xff0000) >> 16,
              ((g >> 2) & 0xff00) >> 8, (b >> 10) & 0xff);
        }
      }
      return outImg;
    }

    img.Image convertYUV420ToImage(CameraImage cameraImage) {
      final width = cameraImage.width;
      final height = cameraImage.height;

      final yRowStride = cameraImage.planes[0].bytesPerRow;
      final uvRowStride = cameraImage.planes[1].bytesPerRow;
      final uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

      final image = img.Image(width:width, height:height);

      for (var w = 0; w < width; w++) {
        for (var h = 0; h < height; h++) {
          final uvIndex =
              uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();
          final index = h * width + w;
          final yIndex = h * yRowStride + w;

          final y = cameraImage.planes[0].bytes[yIndex];
          final u = cameraImage.planes[1].bytes[uvIndex];
          final v = cameraImage.planes[2].bytes[uvIndex];

          image.data!.setPixelR(w, h, yuv2rgb(y, u, v));//= yuv2rgb(y, u, v);
        }
      }
      return image;
    }

    int yuv2rgb(int y, int u, int v) {
      // Convert yuv pixel to rgb
      var r = (y + v * 1436 / 1024 - 179).round();
      var g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
      var b = (y + u * 1814 / 1024 - 227).round();

      // Clipping RGB values to be inside boundaries [ 0 , 255 ]
      r = r.clamp(0, 255);
      g = g.clamp(0, 255);
      b = b.clamp(0, 255);

      return 0xff000000 |
          ((b << 16) & 0xff0000) |
          ((g << 8) & 0xff00) |
          (r & 0xff);
    }

    final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  //TODO convert CameraImage to InputImage
  InputImage? getInputImage() {
    final camera =
    camDirec == CameraLensDirection.front ? cameras[1] : cameras[0];
    final sensorOrientation = camera.sensorOrientation;

    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[cameraController.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) {
      print("Rotation tidak valid");
      return null;
    }

    InputImageFormat? format;
    switch (frame!.format.raw) {
      case 35: // Format NV21 untuk Android
        format = InputImageFormat.nv21;
        break;
      case 33: // Format BGRA8888 untuk iOS
        format = InputImageFormat.bgra8888;
        break;
      default:
        print("Format gambar tidak dikenal: ${frame!.format.raw}");
        return null;
    }

    if (frame!.planes.isEmpty) {
      print("Frame tidak memiliki planes");
      return null;
    }

    final plane = frame!.planes.first;

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(frame!.width.toDouble(), frame!.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
    
  }

    Future<File> cropImage(File imageFile) async {
      final image = img.decodeImage(imageFile.readAsBytesSync())!;
      final circleRadius = 500;
      final centerX = image.width ~/ 2;
      final centerY = image.height ~/2;

      final cropped = img.Image(
        width: image.width,
        height: image.height,
      );
      // final transparentColor = img.getColor(0, 0, 0, 0);
      // img.fill(cropped, color: transparentColor); 

      for (int x = 0; x < image.width; x++) {
        for (int y = 0; y < image.height; y++) {
          final dx = x - centerX;
          final dy = y - centerY;
          if (dx * dx + dy * dy <= circleRadius * circleRadius) {
            cropped.setPixel(x, y, image.getPixel(x, y));
          }
        }
      }                                                   

      final outputFile = File('${path.dirname(imageFile.path)}/cropped_${path.basename(imageFile.path)}');
      outputFile.writeAsBytesSync(img.encodePng(cropped));
      return outputFile;
    }

    Widget buildResult() {
      if (_scanResults == null ||
          cameraController == null ||
          !cameraController.value.isInitialized) {
        return const Center(child: Text('Camera is not initialized'));
      }
      final Size imageSize = Size(
        cameraController.value.previewSize!.height,
        cameraController.value.previewSize!.width,
      );
      CustomPainter painter = FaceDetectorPainter(imageSize, _scanResults, camDirec);
      return CustomPaint(
        painter: painter,
      );
    }

    @override
    Widget build(BuildContext context) {
      List<Widget> stackChildren = [];
      size = MediaQuery.of(context).size;
      if (!isInitialized) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (cameraController != null) {
        //TODO View for displaying the live camera footage
        stackChildren.add(
          Positioned(
            top: 0.0,
            left: 0.0,
            width: size.width,
            height: size.height,
            child: Container(
              child: (cameraController.value.isInitialized)
                  ? AspectRatio(
                aspectRatio: cameraController.value.aspectRatio,
                child: CameraPreview(cameraController),
              )
                  : Container(),
            ),
          ),
        );

        //TODO View for displaying rectangles around detected aces
        stackChildren.add(
          Positioned(
              top: 0.0,
              left: 0.0,
              width: size.width,
              height: size.height,
              child: buildResult()),  
        );
      }
      
      return Scaffold(
        body: Stack(
          children: [
            // CameraPreview(cameraController),
            ClipPath(
              clipper: CircleClipper(),
              child: Container(
                width: double.infinity,  // Ensure width is provided
                height: double.infinity, // Ensure height is provided
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.camera),
                  color: Colors.white,
                  iconSize: 50,
                  onPressed: () async {
                    try {
                      XFile picture = await cameraController.takePicture();
                      File imageFile = File(picture.path);
                      File croppedImage = await cropImage(imageFile);

                      if (croppedImage.existsSync()) {
                        final clockInState = Provider.of<ClockInState>(context, listen: false);
                        if (clockInState.hasClockedIn) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => gmapsClockOutPages(imagePath: croppedImage.path),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => gmapsConfirmPages(imagePath: croppedImage.path),
                            ),
                          );
                        }
                      } else {
                        print("Cropped image not found");
                      }
                    } catch (e) {
                      print("Error taking or cropping picture: $e");
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2 - 50), radius: 150))
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.absoluteImageSize, this.faces, this.camDire2);

  final Size absoluteImageSize;
  final List<Recognition> faces;
  CameraLensDirection camDire2;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.indigoAccent;

    for (Recognition face in faces) {
      canvas.drawRect(
        Rect.fromLTRB(
          camDire2 == CameraLensDirection.front
              ? (absoluteImageSize.width - face.location.right) * scaleX
              : face.location.left * scaleX,
          face.location.top * scaleY,
          camDire2 == CameraLensDirection.front
              ? (absoluteImageSize.width - face.location.left) * scaleX
              : face.location.right * scaleX,
          face.location.bottom * scaleY,
        ),
        paint,
      );

      TextSpan span = TextSpan(
          style: const TextStyle(color: Colors.white, fontSize: 20),
          text: "${face.name}  ${face.distance.toStringAsFixed(2)}");
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(face.location.left*scaleX, face.location.top*scaleY));
    }

  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return true;
  }
}