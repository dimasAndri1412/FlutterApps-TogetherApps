import 'package:absent_project/controller/KPIQuestionsController/platform/platformModel.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class platformController {
  var platforms = <PlatformModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  Future<void> fetchPlatform(int positionId) async {
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse('http://192.168.2.159:8080/FlutterAPI/KPI/platform/getPlatformByPosition.php'),
        body: {
          'position_id' : positionId.toString()
        }
        );

      // print("response: ${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        platforms.value = data.map((json) => PlatformModel.fromJson(json)).toList();
      } else {
        errorMessage.value = 'Failed to load platforms';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }

  addPlatform(int positionId) async{
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/KPI/platform/addPlatform.php"),
        body: {
          'id_position': positionId.toString(),
          'platform_name': platformName.text
        }
      );
      // print('response body: ${response.body}');
      if (response.statusCode == 200) {
        print('platform added');
      } else {
        print('failed brow');
      }
    } catch (e) {
      print('Error : $e');
    }
  }

  editPlatform(int platformId, String platformName) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/KPI/platform/editPlatform.php"),
        body: {
          'id_platform' : platformId.toString(),
          'platform_name': platformName
        }
      );
      print('response bodyL ${response.body}');
      if (response.statusCode == 200) {
        print('Platform updated');
      } else {
        print('Failed brow hayo');
      }
    } catch (e) {
      print('Error : $e');
    }
  }

  deletePlatform(int platformId) async{
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/KPI/platform/deletePlatform.php"),
        body: {
          'id_platform' : platformId.toString()
        }
      );
      if (response.statusCode == 200) {
        print('Platform deleted');
      } else {
        print('failed brow');
      }
    } catch (e) {
      print('error : $e');
    }
  }
}