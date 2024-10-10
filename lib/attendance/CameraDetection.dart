
import 'dart:io';
import 'dart:ui';
import 'package:absent_project/MapsViews/MapsClockOutElapsedTime/GmapsClockOutPages.dart';
import 'package:absent_project/MapsViews/MapsConfirmLocationPages/GmapsConfirmPages.dart';
import 'package:absent_project/attendance/CircleClipper.dart';
import 'package:absent_project/attendance/FaceDetectorPainter.dart';
import 'package:absent_project/controller/AbsentController/ClockInState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'ML/Recognition.dart';
import 'ML/Recognizer.dart';

class CameraDetection extends StatefulWidget {
  CameraDetection({Key? key}) : super(key: key);
  @override
  _CameraDetectionState createState() => _CameraDetectionState();
}

class _CameraDetectionState extends State<CameraDetection> {
  late List<CameraDescription> cameras;
  dynamic controller;
  bool isBusy = false;
  late Size size;
  late CameraDescription description = cameras[1];
  CameraLensDirection camDirec = CameraLensDirection.front;
  late List<Recognition> recognitions = [];

  //TODO declare face detector
  late FaceDetector faceDetector;

  //TODO declare face recognizer
  late Recognizer recognizer;

  // bolean buat face detected 
  bool noFaceDetected = false;


  @override
  void initState() {
    super.initState();
    //TODO initialize face detector
    var options = FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
    faceDetector = FaceDetector(options: options);
    //TODO initialize face recognizer
    recognizer = Recognizer();
    //TODO initialize camera footage
    initializeCamera();
  }

  //TODO code to initialize the camera feed
  initializeCamera() async {
    cameras = await availableCameras();
    description = cameras[1];
    controller = CameraController(description, ResolutionPreset.medium,imageFormatGroup: Platform.isAndroid
    ? ImageFormatGroup.nv21 // for Android
        : ImageFormatGroup.bgra8888,enableAudio: false); // for iOS);
    await controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller.startImageStream((image) => {
        if (!isBusy) {isBusy = true, frame = image, doFaceDetectionOnFrame()}
      });
    });
  }

  //TODO close all resources
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  //TODO face detection on a frame
  dynamic _scanResults;
  CameraImage? frame;
  doFaceDetectionOnFrame() async {
    //TODO convert frame into InputImage format
    print('dfd');
    InputImage? inputImage = getInputImage();
    //TODO pass InputImage to face detection model and detect faces
    List<Face> faces = await faceDetector.processImage(inputImage!);

    print("fl="+faces.length.toString());
    //TODO perform face recognition on detected faces
    performFaceRecognition(faces);
    // setState(() {
    //   _scanResults = faces;
    //   isBusy = false;
    // });

    if (faces.isEmpty && !noFaceDetected) {
      setState(() {
        noFaceDetected = true;
      });
    } else if (faces.isNotEmpty && noFaceDetected) {
      setState(() {
        noFaceDetected = false;
      });
    }
  }

  img.Image? image;
  bool register = false;
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
      Recognition recognition;
      try {
        recognition = await recognizer.recognize(croppedFace!, faceRect);
        if(recognition.distance>1.26){
          recognition.name = "Unknown";
        }
      } catch (e) {
        recognition = Recognition("Face not registered", faceRect, [], 0);
      }
      recognitions.add(recognition);
      //TODO show face registration dialogue
      if(register){
        showFaceRegistrationDialogue(croppedFace!,recognition);
        register = false;
      }

    }

    setState(() {
      isBusy  = false;
      _scanResults = recognitions;
    });

  }

  //TODO Face Registration Dialogue
  TextEditingController textEditingController = TextEditingController();
  showFaceRegistrationDialogue(img.Image croppedFace, Recognition recognition){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Face Registration",textAlign: TextAlign.center),alignment: Alignment.center,
        content: SizedBox(
          height: 340,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              Image.memory(Uint8List.fromList(img.encodeBmp(croppedFace!)),width: 200,height: 200,),
              SizedBox(
                width: 200,
                child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration( fillColor: Colors.white, filled: true,hintText: "Enter Name")
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () {
                    // recognizer.registerFaceInDB(textEditingController.text, recognition.embeddings);
                    // textEditingController.text = "";
                    // Navigator.pop(context);
                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //   content: Text("Face Registered"),
                    // ));
                  },style: ElevatedButton.styleFrom(shadowColor:Colors.blue,minimumSize: const Size(200,40)),
                  child: const Text("Register"))
            ],
          ),
        ),contentPadding: EdgeInsets.zero,
      ),
    );
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

        outImg.setPixelRgb(i, j, ((r << 6) & 0xff0000) >> 16,
            ((g >> 2) & 0xff00) >> 8, (b >> 10) & 0xff);
      }
    }
    return outImg;
  }
 // TODO method to convert CameraImage to Image
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
      _orientations[controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(frame!.format.raw);
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    if (frame!.planes.length != 1) return null;
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


  Widget buildResult() {
    if (_scanResults == null ||
        controller == null ||
        !controller.value.isInitialized) {
      return const Center(child: Text('Camera is not initialized'));
    }
    final Size imageSize = Size(
      controller.value.previewSize!.height,
      controller.value.previewSize!.width,
    );
    CustomPainter painter = FaceDetectorPainter(imageSize, _scanResults, camDirec);
    return CustomPaint(
      painter: painter,
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


  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    size = MediaQuery.of(context).size;
    if (controller != null) {

      // Camera preview with circular clip
      stackChildren.add(
      Positioned.fill(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: CameraPreview(controller),
          ),
        ),
      ),
    );

    // Overlay with circular clip
    stackChildren.add(
      Positioned.fill(
        child: ClipPath(
          clipper: CircleClipper(),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
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

    bool isUnknown = recognitions.any((rec) => rec.name == "Unknown");
    bool isNotRegist = recognitions.any((rec) => rec.name == "Face not registered");
    stackChildren.add(Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Center(
        child: IconButton(
          icon: Icon(Icons.camera),
          color: Colors.white,
          iconSize: 50,
          onPressed: isNotRegist
            ? null
            : isUnknown
            ? null // if Unknown maka gabisa pencet
            : noFaceDetected
            ? null 
            : () async {
            try {
              await controller.stopImageStream(); 
              XFile picture = await controller.takePicture();
              File imageFile = File(picture.path);
              File croppedImage = await cropImage(imageFile);

              if (croppedImage.existsSync()) {
                final clockInState = Provider.of<ClockInState>(context, listen: false);
                if (clockInState.hasClockedIn) {
                  Get.to(gmapsClockOutPages(imagePath: croppedImage.path));
                } else {
                  Get.offAll(gmapsConfirmPages(imagePath: croppedImage.path));
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
    ));

    //TODO View for displaying the bar to switch camera direction or for registering faces
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            margin: const EdgeInsets.only(top: 0),
            color: Colors.black,
            child: Stack(
              children: stackChildren,
            )),
      ),
    );
  }
}
