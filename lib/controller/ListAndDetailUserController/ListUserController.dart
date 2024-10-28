import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'UserList.dart';


class ListUserController {
  Future<List<UserList>?> getUsers() async {
    var data = await http.get(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/readuserlist.php"));
    var jsonData = json.decode(data.body);

    List<UserList> users = [];

    for (var u in jsonData) {
      UserList user = UserList(u["USERNAME"], u["full_name"], u["ROLE"],
          u["grup"], u["email_address"], u["phone_number"], u["image_path"]);
      users.add(user);
    }
    return users;
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


