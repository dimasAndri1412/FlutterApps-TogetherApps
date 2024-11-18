import 'package:absent_project/SA/json/UsersJson/AddUserJson.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../services/ApiService.dart';

class UserController {
  final ApiService apiService;

  UserController({required this.apiService});

  // Method untuk menambahkan user baru
  Future<void> createUser(AddUserJson addUserJson, BuildContext context) async {
    Map<String, dynamic> userData = addUserJson.toJson();

    try {
      var response = await apiService.createUser(userData);
      if (response['status'] == 'success') {
       const SnackBar snackBar = SnackBar(
            content: Text("User created successfully!"),
            backgroundColor: Colors.greenAccent,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        print("Error: ${response['message']}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}
