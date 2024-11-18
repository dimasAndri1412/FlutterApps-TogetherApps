import 'dart:convert';

import 'package:http/http.dart' as http;

class revampInsertResgist {

  String? revampUserName,revampFullName,revampBirthDate,revampAddress,revampRoles,revampPhoneNumber,
      revampEmailAddress,revampPassword,revampProjectName,revampPositionName,revampDivionName,revampCompanyName;
  var revampRegistValues;

  Future revapGegist() async {

    try{

      var insertRegist = Uri.parse("http://192.168.2.159:8080/FlutterAPI/revampRegistrationInsert.php");
      var respRvmpRgst = await http.post(
        insertRegist,
        body: {
          "full_name": revampFullName,
          "USERNAME": revampUserName,
          "birth_date": revampBirthDate,
          "address": revampAddress,
          "ROLE": revampRoles,
          "phone_number": revampPhoneNumber,
          "email_address": revampEmailAddress,
          "PASSWORD": revampPassword,
          "project_name": revampProjectName,
          "position_name": revampPositionName,
          "division_name": revampDivionName,
          "company_name": revampCompanyName
        }
      );

      revampRegistValues = jsonDecode(respRvmpRgst.body);
      print("response: ${respRvmpRgst.body}");

    }catch(errs) {
      print(errs);
    }
  }
}