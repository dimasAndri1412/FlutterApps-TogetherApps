import 'Keys.dart';
import 'package:http/http.dart' as http;

//funsi untuk melakukan penyimpanan data//
class save_func {
  savefunc() async {
    final response = await http.post(
      Uri.parse("http://192.168.2.159/FlutterAPI/create.php"),
      body: {
        "full_name": FullNameController.text,
        "USERNAME": UserNameController.text,
        "birth_date": BirthDateController.text,
        "address": AddressController.text,
        // "grup": addUserField.grupController.text,
        "ROLE": RolesController.text,
        "phone_number": PhoneNumbersController.text,
        "email_address": EmailController.text,
        "PASSWORD": PassController.text,
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  clear_func() {
    FullNameController.clear();
    UserNameController.clear();
    BirthDateController.clear();
    AddressController.clear();
    RolesController.clear();
    PhoneNumbersController.clear();
    EmailController.clear();
    PassController.clear();
    ConfPassController.clear();
  }
}

//funsi untuk melakukan update data//
/*class update_func {
  List listdata = [];

  getdata() async {
    try {
      final response = await http
          .get(Uri.parse("http://192.168.2.159/FlutterAPI/read.php"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          listdata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getdata();
    print(listdata)
    super.initState();
  }
}*/