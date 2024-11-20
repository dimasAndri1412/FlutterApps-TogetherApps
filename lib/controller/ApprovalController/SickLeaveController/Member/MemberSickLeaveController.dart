import 'dart:convert';

import 'package:absent_project/controller/ApprovalController/SickLeaveController/Admin/ListSickLeaveModel.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/LoginController.dart';
import 'package:http/http.dart' as http;

class MemberSickLeaveController {
  LoginController _loginController = LoginController();

  Future<List<ListSickLeaveModel>?> getList() async {
    String? userId = await _loginController.getUserId();
    try {
      var response =await http.post(
         Uri.parse(
          "http://192.168.2.159:8080/FlutterAPI/approvals/member/sick_leave/getListPengajuan.php"),
          body: {
          'userId' : userId
        }
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData is List) {
          List<ListSickLeaveModel> users = jsonData
              .map((user) => ListSickLeaveModel.fromJson(user))
              .toList();
          return users;
        } else {
          print("Unexpected JSON format");
          return null;
        }
      } else {
        print("Failed to fetch : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  insertPengajuan() async{
    String? userId = await _loginController.getUserId();
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/approvals/member/sick_leave/insertPengajuan.php"),
        body: {
          'userId' : userId,
          'date': dateSickLeaveController.text,
          'note': noteSickLeaveController.text 
        }
      );
      print('response body: ${response.body}');
      if (response.statusCode == 200) {
        print('Request added');
        return true;
      } else {
        print('failed brow');
        return false;
      }
    } catch (e) {
      print('Error : $e');
    }
  }
}