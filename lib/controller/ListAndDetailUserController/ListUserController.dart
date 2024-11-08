import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'UserList.dart';


class ListUserController {

  Future<String?> getManagerName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('manager_name');
  }

  Future<List<UserList>?> getUsers() async {

    String? managerName = await getManagerName();
    if(managerName == null){
      print('Manager Name Not Found');
      return null;
    }

    var data = await http.get(
        Uri.parse("http://192.168.2.159:8080/FlutterAPI/readuserlist.php?manager_name=$managerName"));
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


