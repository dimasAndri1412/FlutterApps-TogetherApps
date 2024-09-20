import 'package:absent_project/controller/KPIQuestionsController/position/PositionModel.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PositionController extends GetxController {
  var positions = <positionModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
   var selectedPosition = Rxn<int>();
  Future<void> fetchPositions() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://10.233.65.119/FlutterAPI/KPI/getPositions.php'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        positions.value = data.map((json) => positionModel.fromJson(json)).toList();
      } else {
        errorMessage.value = 'Failed to load positions';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
  void setPosition(int? positionId) {
    selectedPosition.value = positionId;
  }

  addPosition() async{
    try {
      final response = await http.post(
        Uri.parse("http://10.233.65.119/FlutterAPI/KPI/addPositions.php"),
        body: {
          'position_name' : positionName.text
        }
      );
      if (response.statusCode == 200) {
        print('Position added');
      } else{
        print('failed brow');
      }
    } catch (e) {
      print('Error : $e');
    }
  }
}
