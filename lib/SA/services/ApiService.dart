import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Companies.dart';
import '../model/Positions.dart';
import '../model/Users.dart';

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

  Future<List<Companies>> getCompany() async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/FlutterAPI/SA/manage/get_company.php"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (body['status'] == 'success') {
          return (body['companies'] as List)
              .map((json) => Companies.fromJson(json))
              .toList();
        } else {
          throw Exception(body['message'] ?? 'Unknown error');
        }
      } else {
        throw Exception('Server returned status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching companies: $error');
    }
  }

  Future<List<Users>> getUsersByCompanyId(int companyId) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/FlutterAPI/SA/manage/list_users.php"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(
            {"company": {"company_id": companyId}}
        ),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['status'] == 'success') {
          return (body['users'] as List)
              .map((json) => Users.fromJson(json))
              .toList();
        } else {
          throw Exception(body['message']);
        }
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

