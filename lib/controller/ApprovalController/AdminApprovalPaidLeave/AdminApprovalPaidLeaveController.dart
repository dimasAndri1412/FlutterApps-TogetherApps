import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;
import 'AdminApprovalPaidLeave.dart';

class UserRequestPaidLeaveController {
  Future<List<UserRequestPaidLeave>?> getUsers() async {
      try{
        var url = Uri.parse(
            "http://192.168.2.159/FlutterAPI/approvals/admin/paid_leave/getUserDevelopment_paidLeave.php");
        var data = await http.post(url, body: {
          "name": namePaidLeave.text
        });
        if (data.statusCode == 200) {
          var jsonData = json.decode(data.body);
          List<UserRequestPaidLeave> users = [];
          for (var u in jsonData) {
            UserRequestPaidLeave user = UserRequestPaidLeave(
                u["name"], u["position"], u["reqNo"], u["status"],
                u["date_start_leave"]);
            users.add(user);
          }
          return users;
        }
        return null;
      }catch (Exception) {
        "Failed Request!";
      }
    }
}
