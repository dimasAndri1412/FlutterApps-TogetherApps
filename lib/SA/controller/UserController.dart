import 'package:flutter/material.dart';
import '../model/Companies.dart';
import '../model/Positions.dart';
import '../services/ApiService.dart';

class UserController {
  final ApiService apiService;

  UserController({required this.apiService});

  Future<List<Positions>> getPositions() async {
    try {
      return await apiService.getPosition();
    } catch (error) {
      throw Exception('Failed to fetch positions');
    }
  }

  Future<List<Companies>> getCompany() async{
    try{
      return await apiService.getCompany();
    } catch(error){
      throw Exception('Failed to fetch company');
    }
  }

  Future<void> createUser(Map<String, dynamic> userData, BuildContext context) async {
    try {
      var response = await apiService.createUser(userData);
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
