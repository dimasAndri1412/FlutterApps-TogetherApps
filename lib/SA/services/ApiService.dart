import 'dart:convert';
import 'package:http/http.dart' as http;

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
        throw Exception('Failed to create user');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
