import 'dart:convert';
import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;

class FindUserNamesAndEmails {
  String? userNames, emailNames;
  dynamic userNameAndEmailValues;

  Future<void> verifyUserNameAndEmails() async {
    try {
      var getEmailAndUserNames = Uri.parse(
          "http://192.168.2.159:8080/FlutterAPI/verifyUserNamesAndEmailAddress.php");

      var respEmailAndUsrName = await http.post(
        getEmailAndUserNames,
        body: {
          'USERNAME': userNames ?? '',
          'email_address': emailNames ?? '',
        },
      );

      if (respEmailAndUsrName.statusCode == 200) {
        try {
          userNameAndEmailValues = jsonDecode(respEmailAndUsrName.body);
        } catch (e) {
          print("Error parsing JSON: $e");
          userNameAndEmailValues = [];
        }
      } else {
        print(
            "Error: ${respEmailAndUsrName.statusCode} - ${respEmailAndUsrName.body}");
        userNameAndEmailValues = [];
      }
    } catch (errs) {
      print("Error: $errs");
      rethrow;
    }
  }

  Future<bool> getUserNameAndEmail() async {
    for (var verifyControllers in revampResgistControllerss) {
      final findUserNamesAndEmailss = FindUserNamesAndEmails();
      findUserNamesAndEmailss.userNames =
          verifyControllers["revampUserNameController"]?.text;
      findUserNamesAndEmailss.emailNames =
          verifyControllers["revampEmailController"]?.text;

      await findUserNamesAndEmailss.verifyUserNameAndEmails();
      final userNameAndEmailValues =
          findUserNamesAndEmailss.userNameAndEmailValues;

      if (userNameAndEmailValues is List && userNameAndEmailValues.isNotEmpty) {
        return false; // Data sudah ada
      }
    }
    return true; // Tidak ada konflik data
  }
}
