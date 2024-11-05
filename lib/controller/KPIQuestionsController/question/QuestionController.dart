 import 'dart:convert';
import 'package:absent_project/controller/KPIQuestionsController/question/QuestionModel.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
 
 class Questioncontroller {
  Future<List<QuestionModel>> getQuestions(int positionId) async {
    try {
      final response = await http.post(
      Uri.parse("http://192.168.2.159:8080/FlutterAPI/KPI/getQuestions.php"),
        body: {
          'id_position': positionId.toString()
        }
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<QuestionModel> questions = jsonData.map((item) => QuestionModel.fromJson(item)).toList();
        return questions;
      } else {
        print("Failed to load questions");
        return [];
      }
    } catch (e) {
      print('error: $e');
      return[];
    }
  }

  addQuestion(int positionId) async{
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/KPI/addQuestions.php"),
        body: {
          'id_position': positionId.toString(),
          'question_text': questionText.text
        }
      );
      print('response body: ${response.body}');
      if (response.statusCode == 200) {
        print('Question added');
      } else {
        print('failed brow');
      }
    } catch (e) {
      print('Error : $e');
    }
  }

  editQuestion(int questionId, String questionText) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/KPI/editQuestions.php"),
        body: {
          'id_question' : questionId.toString(),
          'question_text': questionText
        }
      );
      print('response bodyL ${response.body}');
      if (response.statusCode == 200) {
        print('Question updated');
      } else {
        print('Failed brow hayo');
      }
    } catch (e) {
      print('Error : $e');
    }
  }

  deleteQuestion(int questionId) async{
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/KPI/deleteQuestions.php"),
        body: {
          'id_question' : questionId.toString()
        }
      );
      if (response.statusCode == 200) {
        print('Question deleted');
      } else {
        print('failed brow');
      }
    } catch (e) {
      print('error : $e');
    }
  }
 }