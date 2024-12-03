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
      final response = await http.get(Uri.parse('http://192.168.2.159:8080/FlutterAPI/KPI/getPositions.php'));

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
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/KPI/addPositions.php"),
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

  editPosition(int positionId, String positionName) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/KPI/editPositions.php"),
        body: {
          'id_position' : positionId.toString(),
          'position_name': positionName
        }
      );
      print('response bodyL ${response.body}');
      if (response.statusCode == 200) {
        print('Position updated');
      } else {
        print('Failed brow hayo');
      }
    } catch (e) {
      print('Error : $e');
    }
  }

  deletePosition(int positionId) async{
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/KPI/deletePositions.php"),
        body: {
          'id_position' : positionId.toString()
        }
      );
      // print('response${response.body}');
      if (response.statusCode == 200) {
        print('Position deleted');
      } else {
        print('failed brow');
      }
    } catch (e) {
      print('error : $e');
    }
  }
}
