import 'dart:convert';
import 'dart:io';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionModel.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/LoginController.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClockInController {

  LoginController _loginController = LoginController();

  Future<String> fetchUserName() async {
    String? userId = await _loginController.getUserId();
    if (userId != null) {
      var response = await http.get(Uri.parse('http://192.168.100.194/FlutterAPI/GetUserById.php/$userId'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['full_name'];
      } else {
        throw Exception('Failed to load user');
      }
    } else {
      throw Exception('User ID not found');
    }
  }

  Future<String> fetchProject() async {
    String? userId = await _loginController.getUserId();
    if (userId != null) {
      var response = await http.get(
        Uri.parse(
          'http://192.168.100.194/FlutterAPI/GetUserById.php/$userId'
        )
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Data fetched: $data');
        return data['grup'];
      } else {
        throw Exception('Failed to load user');
      }
    } else {
      throw Exception('User ID not found');
    }
  }

  clear_func() {
   locationClockIn.clear();
   shiftController.clear();
   notesClockIn.clear();
   clockInImageController.clear();

   clockOutImageController.clear();
   locationClockOut.clear();
   notesClockOut.clear();
  }

  bool _isLoading = false;
  clock_in() async {
  try {
    String? userId = await _loginController.getUserId();
    if (userId == null) {
      print('User ID tidak ditemukan');
      return false;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://192.168.100.194/FlutterAPI/attendance/user/clock_in.php"),
    );
    
    request.fields['user_id'] = userId;
    request.fields['location'] = locationClockIn.text;
    request.fields['shift'] = shiftController.text;
    request.fields['notes'] = notesClockIn.text;
    
    if (clockInImageController.text.isNotEmpty) {
      final filePath = clockInImageController.text;
      final file = File(filePath);

      if (await file.exists()) {
        var imageFile = await http.MultipartFile.fromPath("pict_clock_in", filePath);
        request.files.add(imageFile);
      } else {
        print('File tidak ditemukan di path: $filePath');
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print('Image: ${clockInImageController.text}');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
    String responseBody = response.body;

    // Coba temukan posisi awal JSON dengan mencari '{'
    int jsonStartIndex = responseBody.indexOf('{');
    if (jsonStartIndex != -1) {
      // Ambil bagian respons yang mengandung JSON
      String jsonResponse = responseBody.substring(jsonStartIndex);
      try {
        var responseData = jsonDecode(jsonResponse);
        if (responseData['Message'] == 'Clock-in Sukses') {
          return true;
        }
      } catch (jsonError) {
        print('Error parsing JSON: $jsonError');
      }
    } else {
      print('Unexpected response format: $responseBody');
    }
  }
  return false;

  } catch (e) {
    print('Exception during clock in request: $e');
    return false;
  }
}

  show_question() async {
    try {
      String? userId = await _loginController.getUserId();
      if (userId == null) {
        print('User ID tidak ditemukan');
        return false;
      }

      final response = await http.post(
        Uri.parse("http://192.168.100.194/FlutterAPI/KPI/getQuestionsForClockOut.php"),
        body: {
          'user_id' : userId
        }
      );
      print('response body: ${response.body}');
      if (response.statusCode == 200) {
        print('success');
        List<dynamic> jsonData = jsonDecode(response.body);
        List<QuestionModel> questions = jsonData.map((item) => QuestionModel.fromJson(item)).toList();
        return questions;
      } else {
        print("fail");
      }
    } catch (e) {
      print('Error : $e');
    }
  }
 
  clock_out() async {
    try {
      String? userId = await _loginController.getUserId();
      if (userId == null) {
        print('User ID tidak ditemukan');
        return false;
      }

      List<QuestionModel> questions = await show_question();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://192.168.100.194/FlutterAPI/attendance/user/clock_out.php"),
      );
      
      request.fields['user_id'] = userId;
      request.fields['location'] = locationClockOut.text;
      request.fields['shift'] = shiftController.text;
      request.fields['notes'] = notesClockOut.text;
      if (clockOutImageController.text.isNotEmpty) {
        final filePath = clockOutImageController.text;
        final file = File(filePath);

        if (await file.exists()) {
          var imageFile = await http.MultipartFile.fromPath("pict_clock_out", filePath);
          request.files.add(imageFile);
        } else {
          print('File tidak ditemukan di path: $filePath');
        }
      }

      for (var question in questions) {
        final questionId = question.idQuestion.toString(); 
        final answer = answerController[questionId]?.text ?? ''; 
        request.fields[questionId] = answer;
        print('Submitting answer for question $questionId: $answer');
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Image path: ${clockOutImageController.text}");
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      

      if (response.statusCode == 200) {
        String responseBody = response.body;

        int jsonStartIndex = responseBody.indexOf('{');
        if (jsonStartIndex != -1) {
          String jsonResponse = responseBody.substring(jsonStartIndex);
          try {
            var responseData = jsonDecode(jsonResponse);
            
            // Tambahkan pengecekan ini agar selalu mengembalikan true jika sukses
            if (responseData['status'] == 'success') {
              print('Clock Out berhasil');
              return true;
            } else {
              print('Clock Out gagal dengan pesan: ${responseData['Message']}');
            }
          } catch (jsonError) {
            print('Error parsing JSON: $jsonError');
          }
        } else {
          print('Unexpected response format: $responseBody');
        }
      }
      return false;
    } catch (e) {
      print('Exception during clock in request: $e');
      return false;
    }
  }
}

