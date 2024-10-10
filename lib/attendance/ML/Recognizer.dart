import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:absent_project/controller/AbsentController/RegistratedFace.dart';
import 'package:http/http.dart' as http;
import 'package:absent_project/controller/LoginController.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
// import '../DB/DatabaseHelper.dart';
import 'Recognition.dart';

class Recognizer {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;
  static const int WIDTH = 112;
  static const int HEIGHT = 112;
  // Map<String,Recognition> registered = Map();
  // RegistratedFace? registeredFace; 
  List<double>? embeddingList;
  @override
  String get modelName => 'assets/mobile_face_net.tflite';

  Recognizer({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }
    loadModel();
    // initDB();
  }

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset(modelName);
    } catch (e) {
      print('Unable to create interpreter, Caught Exception: ${e.toString()}');
    }
  }

  List<dynamic> imageToArray(img.Image inputImage){
    img.Image resizedImage = img.copyResize(inputImage!, width: WIDTH, height: HEIGHT);
    List<double> flattenedList = resizedImage.data!.expand((channel) => [channel.r, channel.g, channel.b]).map((value) => value.toDouble()).toList();
    Float32List float32Array = Float32List.fromList(flattenedList);
    int channels = 3;
    int height = HEIGHT;
    int width = WIDTH;
    Float32List reshapedArray = Float32List(1 * height * width * channels);
    for (int c = 0; c < channels; c++) {
      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
          int index = c * height * width + h * width + w;
          reshapedArray[index] = (float32Array[c * height * width + h * width + w]-127.5)/127.5;
        }
      }
    }
    return reshapedArray.reshape([1,112,112,3]);
  }

  LoginController _loginController = LoginController();
  Future<List<double>> fetchEmbedding() async {
    String? userId = await _loginController.getUserId();
    if (userId == null) {
      print("null userID");
    }

    final response = await http.post(
      Uri.parse('http://192.168.100.84/FlutterAPI/attendance/admin/GetEmbeddingById.php'),
      body: {'user_id': userId},
    );

    if (response.statusCode == 200) {
      var registeredEmbedding = jsonDecode(response.body);
      print(registeredEmbedding); // Debugging print

      // Mendapatkan string embedding dan menghilangkan tanda kutip tambahan
      String embeddingString = registeredEmbedding[0]['embedding'].replaceAll("\"", "");

      // Pisahkan string menjadi daftar dan ubah setiap elemen menjadi double
      embeddingList = embeddingString
          .split(',')
          .map((e) => double.parse(e))
          .toList();

      return embeddingList!;

    } else {
      throw Exception('Failed to load embedding');
    }
  }


  Future<Recognition> recognize(img.Image image, Rect location) async {
    // Pastikan embeddingList tidak null
    if (embeddingList == null) {
      await fetchEmbedding();
      if (embeddingList == null) {
        throw Exception('Face not registered');
      }
    }

    // Proses input image
    var input = imageToArray(image);
    print(input.shape.toString());

    // Output array untuk hasil inferensi
    List output = List.filled(1 * 192, 0).reshape([1, 192]);

    // Lakukan inferensi
    final runs = DateTime.now().millisecondsSinceEpoch;
    interpreter.run(input, output);
    final run = DateTime.now().millisecondsSinceEpoch - runs;
    print(jsonEncode(output));
    print('Time to run inference: $run ms$output');

    // Konversi output ke List<double>
    List<double> outputArray = output.first.cast<double>();

    // Temukan embedding terdekat
    Pair pair = findNearest(outputArray, embeddingList!);
    print("distance= ${pair.distance}");

    return Recognition(pair.name, location, outputArray, pair.distance);
  }

  Pair findNearest(List<double> emb, List<double> embeddingList) {
    double distance = 0;
    for (int i = 0; i < emb.length; i++) {
      double diff = emb[i] - embeddingList[i];
      distance += diff * diff;
    }
    distance = sqrt(distance);

    // Tentukan ambang batas untuk mencocokkan
    double threshold = 2.0; // Sesuaikan dengan kebutuhan Anda
    if (distance <= threshold) {
      return Pair("Success", distance);
    } else {
      return Pair("Unknown", distance);
    }
  }

  void close() {
    interpreter.close();
  }
}

class Pair{
   String name;
   double distance;
   Pair(this.name,this.distance);
}
