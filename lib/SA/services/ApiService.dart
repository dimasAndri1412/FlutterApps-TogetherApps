import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Positions.dart';

class ApiService {
  final String _baseUrl = 'http://192.168.2.159:8080';

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/FlutterAPI/SA/create/create_user.php"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create user: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<List<Positions>> getPosition() async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/FlutterAPI/SA/create/get_position.php"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (body['status'] == 'success') {
          return (body['positions'] as List)
              .map((json) => Positions.fromJson(json))
              .toList();
        } else {
          throw Exception(body['message'] ?? 'Unknown error');
        }
      } else {
        throw Exception('Server returned status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching positions: $error');
    }
  }
}
