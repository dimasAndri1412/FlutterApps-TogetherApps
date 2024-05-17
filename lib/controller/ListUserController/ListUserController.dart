import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'UserList.dart';


class ListUserContoller {
  Future<List<UserList>> getUsers() async {
    var data = await http.get(
        Uri.parse("http://192.168.2.159/FlutterAPI/readuserlist_bak.php"));
    var jsonData = json.decode(data.body);

    List<UserList> users = [];

    for (var u in jsonData) {
      UserList user = UserList(u["USERNAME"]);
      users.add(user);
    }
    return users;
  }
}
