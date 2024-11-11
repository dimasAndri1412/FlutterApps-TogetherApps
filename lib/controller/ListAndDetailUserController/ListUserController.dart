import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'UserList.dart';


class ListUserController {

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  Future<List<UserList>?> getUsers() async {
    String? managerName = await getUserId();
    if (managerName == null) {
      print('Manager Name Not Found');
      return null;
    }

    var data = await http.post(
        Uri.parse(
            "http://192.168.2.159:8080/FlutterAPI/readuserlist.php"
        ), body: {
      "manager_name": managerName,
    }
    );

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);

      List<UserList> users = [];

      for (var u in jsonData) {
        UserList user = UserList(
            u["username"] ?? "",
            u["full_name"] ?? "",
            u["role"] ?? "",
            u["project_name"] ?? "",
            u["email_address"] ?? "",
            u["phone_number"] ?? "",
            u["image_path"] ?? ""
        );
        users.add(user);
      }
      return users;
    }
    return null;
  }

  Future<Map<String, dynamic>> deleteUser(String email) async {
    var response = await http.post(
      Uri.parse("http://192.168.2.159:8080/FlutterAPI/delete_user.php"),
      body: {"email": email},
    );
    print(response.body); // Log respons untuk debugging
    var jsonData = json.decode(response.body);
    return jsonData;
  }
}


