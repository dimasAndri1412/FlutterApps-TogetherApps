import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:absent_project/controller/AbsentController/RegistratedFace.dart';
// import '../HomeScreen.dart';
import 'Recognition.dart';

class Recognizer {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;
  static const int WIDTH = 112;
  static const int HEIGHT = 112;
  // final dbHelper = RegistrationFace();
  Map<String, Recognition> registered = {};

  static const String modelName = 'assets/mobile_face_net.tflite';

  Recognizer({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }
    loadModel();
    // initDB();
  }

  // initDB() async {
  //   await loadRegisteredFaces();
  // }

  // Future<void> loadRegisteredFaces() async {
  //   final allRows = await dbHelper.queryAllRows();
  //   for (final row in allRows) {
  //     String name = row['name'];
  //     String embeddingsString = row['embedding'];
  //     // print("Raw embeddings string: $embeddingsString");

  //     List<double> embd;
  //     try {
  //       embd = embeddingsString
  //           .split(',')
  //           .map((e) {
  //             try {
  //               return double.parse(e);
  //             } catch (e) {
  //               print("Error parsing double from '$e': $e");
  //               return 0.0; 
  //             }
  //           })
  //           .toList()
  //           .cast<double>();
  //     } catch (e) {
  //       print("Error converting embeddings to list: $e");
  //       continue; 
  //     }

  //     if (embd.length != 512) {
  //       print('Invalid embedding length for $name: ${embd.length}');
  //       continue;
  //     }

  //     Recognition recognition = Recognition(name, Rect.zero, embd, 0);
  //     registered[name] = recognition;
  //   }
  // }

  // void registerFaceInDB(String name, String embedding) async {
  //   Map<String, dynamic> row = {
  //     'name': name,
  //     'embedding': embedding
  //   };
  //   final id = await dbHelper.insert(row);
  //   print('inserted row id: $id');
  // }

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset(modelName);
    } catch (e) {
      print('Unable to create interpreter, Caught Exception: ${e.toString()}');
    }
  }

  List<dynamic> imageToArray(img.Image inputImage) {
    img.Image resizedImage =
        img.copyResize(inputImage, width: WIDTH, height: HEIGHT);
    List<double> flattenedList = resizedImage.data!
        .expand((channel) => [channel.r, channel.g, channel.b])
        .map((value) => value.toDouble())
        .toList();
    Float32List float32Array = Float32List.fromList(flattenedList);
    int channels = 3;
    int height = HEIGHT;
    int width = WIDTH;
    Float32List reshapedArray = Float32List(1 * height * width * channels);
    for (int c = 0; c < channels; c++) {
      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
          int index = c * height * width + h * width + w;
          reshapedArray[index] = float32Array[c * height * width + h * width + w];
        }
      }
    }
    return reshapedArray.reshape([1, 112, 112, 3]);
  }

  Recognition recognize(img.Image image, Rect location) {
    var input = imageToArray(image);
    print(input.shape.toString());

    List output = List.filled(1 * 192, 0).reshape([1, 192]);

    final runs = DateTime.now().millisecondsSinceEpoch;
    interpreter.run(input, output);
    final run = DateTime.now().millisecondsSinceEpoch - runs;
    print('Time to run inference: $run ms$output');

    List<double> outputArray = output.first.cast<double>();

    Pair pair = findNearest(outputArray);
    print("distance= ${pair.distance}");

    return Recognition(pair.name, location, outputArray, pair.distance);
  }

  Pair findNearest(List<double> emb) {
    if (emb.length != 192) {
      throw RangeError('Embedding array does not have the expected length of 192');
    }

    Pair pair = Pair("Unknown", -5);
    for (var item in registered.entries) {
      final String name = item.key;
      List<double> knownEmb = item.value.embeddings;

      if (knownEmb.length != 192) {
        print('Registered embedding for $name does not have the expected length of 192');
        continue;
      }

      double distance = 0;
      for (int i = 0; i < emb.length; i++) {
        double diff = emb[i] - knownEmb[i]; 
        distance += diff * diff;
      }
      distance = sqrt(distance);
      if (pair.distance == -5 || distance < pair.distance) {
        pair.distance = distance;
        pair.name = name;
      }
    }
    return pair;
  }

  void close() {
    interpreter.close();
  }
}

class Pair {
  String name;
  double distance;
  Pair(this.name, this.distance);
}
