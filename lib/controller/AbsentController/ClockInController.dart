import 'dart:convert';
import 'dart:io';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/LoginController.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClockInController {

  LoginController _loginController = LoginController();

  Future<String> fetchUserName() async {
    String? userId = await _loginController.getUserId();
    if (userId != null) {
      var response = await http.get(Uri.parse('http://10.233.68.96/FlutterAPI/GetUserById.php/$userId'));
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
          'http://10.233.68.96/FlutterAPI/GetUserById.php/$userId'
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
      Uri.parse("http://10.233.68.96/FlutterAPI/attendance/user/clock_in.php"),
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


  // clock_in() async {
  //   try {
  //     String? userId = await _loginController.getUserId();
  //     if (userId == null) {
  //       print('User ID tidak ditemukan');
  //       return false;
  //     }

  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse("http://10.233.115.160/FlutterAPI/attendance/user/clock_in.php"),
  //     );
      
  //     request.fields['user_id'] = userId;
  //     request.fields['location'] = locationClockIn.text;
  //     request.fields['shift'] = shiftController.text;
  //     request.fields['notes'] = notesClockIn.text;
  //     // request.fields['pict_clock_in'] = clockInImageController.text;
      
  //     // if (clockInImageController != null) {
  //     //   var imageFile = await http.MultipartFile.fromPath("pict_clock_in", clockInImageController.text);
  //     //   request.files.add(imageFile);
  //     // }
  //     if (clockInImageController.text.isNotEmpty) {
  //     // Periksa apakah file benar-benar ada
  //     final filePath = clockInImageController.text;
  //     final file = File(filePath);

  //     if (await file.exists()) {
  //       var imageFile = await http.MultipartFile.fromPath("pict_clock_in", filePath);
  //       request.files.add(imageFile);
  //     } else {
  //       print('File tidak ditemukan di path: $filePath');
  //     }
  //   }

  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //     print('Response Status Code: ${response.statusCode}');
  //     print('Response Body: ${response.body}');

  //     if (response.statusCode == 200) {
  //     // Pisahkan JSON dari pesan lainnya
  //     String responseBody = response.body;
  //     int jsonStartIndex = responseBody.indexOf('{');
  //     if (jsonStartIndex != -1) {
  //       var responseData = jsonDecode(responseBody.substring(jsonStartIndex));
  //       if (responseData['Message'] == 'Clock-in Sukses') {
  //         return true;
  //       }
  //     }
  //     return false;
  //   } else {
  //     return false;
  //   }
  //   } catch (e) {
  //     print('Exception during clock in request: $e');
  //     return false;
  //   }
  // }

  clock_out() async {
    try {
      String? userId = await _loginController.getUserId();
      if (userId == null) {
        print('User ID tidak ditemukan');
        return false;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://10.233.68.96/FlutterAPI/attendance/user/clock_out.php"),
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

