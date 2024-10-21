import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Keys.dart';
import 'MemberDetailInfo.dart';

class detailMember {
  Future<List<MemberDetailInfo>?> getUsers() async {
    var url = Uri.parse("http://192.168.2.159:8080/FlutterAPI/ReadMemberInfo.php");
    var data = await http.post(url,
      body: {"username": emailController.text});
    var jsonData = json.decode(data.body);

    List<MemberDetailInfo> users = [];

    for (var u in jsonData) {
      MemberDetailInfo user = MemberDetailInfo(u["USERNAME"], u["full_name"], u["ROLE"],
          u["grup"], u["email_address"], u["phone_number"]);
      users.add(user);
    }
    return users;
  }
}