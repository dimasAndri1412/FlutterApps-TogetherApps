import 'package:absent_project/SA/model/Divisions.dart';
import 'package:absent_project/SA/model/Users.dart';
import 'package:flutter/material.dart';
import '../model/Companies.dart';
import '../model/Positions.dart';
import '../model/Projects.dart';
import '../services/ApiService.dart';

class UserController{
  static final ApiService _apiService = ApiService();

  static Future<List<Positions>> getPositions() async {
    try {
      return await _apiService.getPosition();
    } catch (error) {
      throw Exception('Failed to fetch positions');
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

  static Future<void> createUserWithExistingCompany(Map<String, dynamic> userData, BuildContext context) async{
    try{
      var response = await _apiService.createUserWithExistingCompany(userData);
      if(response['status'] == 'success'){
      }else{
        throw Exception(response['message']);
      }
    }catch(error){
      throw Exception("Failed to create user with existing company: $error");
    }
  }

  static Future<List<Users>> getUsersByCompanyIdAndDivisionId(int companyId, int divisionId, int projectId) async{
    try{
      return await _apiService.getUsersByCompanyIdAndDivisionId(companyId, divisionId, projectId);
    }catch (error){
      throw Exception("Failed to fetch project");
    }
  }
}
