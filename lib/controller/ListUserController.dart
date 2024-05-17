import 'dart:async';
import 'dart:convert';

import 'Keys.dart';
import 'package:http/http.dart' as http;

class ListUserController {

  Future<String> doList() async {
    final response = await http.get(Uri.parse("http://192.168.2.159/FlutterAPI/AdminLogin.php"));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> data = jsonDecode(response.body);
      // Convert the list to a string
      String dataAsString = data.join(', '); // Join elements with a separator
      return dataAsString;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data from MySQL');
    }
  }
}

