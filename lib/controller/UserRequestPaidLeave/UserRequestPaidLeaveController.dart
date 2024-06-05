import 'dart:convert';
import 'package:http/http.dart' as http;
import 'UserRequestPaidLeave.dart';

class UserRequestPaidLeaveController {
  Future<List<UserRequestPaidLeave>?> getUsers() async {
    var url = Uri.parse(
        "http://192.168.2.159/FlutterAPI/approvals/admin/paid_leave/getUserApprovalAdmin.php");
    var data = await http.post(url);
    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);
      List<UserRequestPaidLeave> users = [];

      for (var u in jsonData) {
        UserRequestPaidLeave user = UserRequestPaidLeave(u["name"], u["position"], u["reqNo"], u["status"]);
        users.add(user);
      }
      return users;
    }
    return null;
  }
}
