import 'Keys.dart';
import 'package:http/http.dart' as http;

class ctr_data {
  //fungsi untuk melakukan penyimpanan data//
  savefunc() async {
    final response = await http.post(
      Uri.parse("http://192.168.2.159/FlutterAPI/create.php"),
      body: {
        "full_name": FullNameController.text,
        "USERNAME": UserNameController.text,
        "birth_date": BirthDateController.text,
        "address": AddressController.text,
        "grup": ProjectController.text,
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

  //fungsi untuk melakukan penghapusan data//
  clear_func() {
    FullNameController.clear();
    UserNameController.clear();
    BirthDateController.clear();
    AddressController.clear();
    RolesController.clear();
    PhoneNumbersController.clear();
    EmailController.clear();
    NewConfPasswordController.clear();
    NewPasswordContorller.clear();
    PassController.clear();
    ConfPassController.clear();
    ProjectController.clear();
    OTPController.clear();
  }

  clear_maps_func() {
    SearchLocationController.clear();
    nameLocationController.clear();
    stateLocationController.clear();
    subStateLocationController.clear();
    localityLocationController.clear();
    SubLocalityLocationController.clear();
    postalCodeController.clear();
    StreetLocationController.clear();
    localityLocationController.clear();
    latitudeLocationController.clear();
    radiusController.clear();
  }

  update_pwd() async {
    final response = await http.post(
      Uri.parse("http://192.168.2.159/FlutterAPI/update_password.php"),
      body: {
        "OLD_PASSWORD": passwordController.text,
        "PASSWORD": NewPasswordContorller.text,
      },
    );
    if (response.statusCode == 200){
      return true;
    }
    return false;
  }
  
  forgot_pwd() async {
    final response = await http.post(
      Uri.parse("http://192.168.2.159/FlutterAPI/forgot_password.php"),
      body: {
        "email_address" : EmailController.text,
        "PASSWORD" : NewPasswordContorller.text
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
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
