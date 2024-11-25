import 'package:absent_project/SA/model/Divisions.dart';
import 'package:flutter/material.dart';
import '../model/Companies.dart';
import '../model/Positions.dart';
import '../model/Projects.dart';
import '../services/ApiService.dart';

class UserController {
  static final ApiService _apiService = ApiService();

  static Future<List<Positions>> getPositions() async {
    try {
      return await _apiService.getPosition();
    } catch (error) {
      throw Exception('Failed to fetch positions');
    }
  }

  static Future<List<Companies>> getCompany() async {
    try {
      return await _apiService.getCompany();
    } catch (error) {
      throw Exception('Failed to fetch company');
    }
  }

  static Future<List<Divisions>> getDivisionsByCompanyId(int companyId) async {
    try {
      return await _apiService.getDivisionsByCompanyId(companyId);
    } catch (error) {
      throw Exception('Failed to fetch division');
    }
  }

  static Future<List<Projects>> getProjectByCompanyIdAndDivisionId(int companyId, int divisionId) async{
    try{
      return await _apiService.getProjectByCompanyIdAndDivisionId(companyId, divisionId);
    }catch (error){
      throw Exception("Failed to fetch project");
    }
  }

  static Future<void> createUser(Map<String, dynamic> userData, BuildContext context) async {
    try {
      var response = await _apiService.createUser(userData);
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User created successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${response['message']}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
