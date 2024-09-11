import 'Keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:absent_project/login/getDevice.dart';
import 'dart:io';

class ctr_data {
  //fungsi untuk melakukan penyimpanan data//
  savefunc() async {
    final response = await http.post(
      Uri.parse("http://192.168.100.55/FlutterAPI/create.php"),
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
    UserIdController.clear();
    FaceImageController.clear();
    EmbeddingController.clear();
  }

  // update_pwd() async {
  //   final response = await http.post(
  //     Uri.parse("http://10.233.85.124/FlutterAPI/update_password.php"),
  //     body: {
  //       "OLD_PASSWORD": passwordController.text,
  //       "PASSWORD": NewPasswordContorller.text,
  //     },
  //   );
  //   if (response.statusCode == 200){
  //     return true;
  //   }
  //   return false;
  // }
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
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
    // if (image == null || !faceDetected) return false;
    final deviceService = Getdevice();
    String deviceId = await deviceService.getDeviceId();
    try {
      String? userId = await getUserId();
      if (userId == null) {
        print('User ID tidak ditemukan');
        return false;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://192.168.100.55/FlutterAPI/update_password.php"),
      );

      request.fields['OLD_PASSWORD'] = passwordController.text;
      request.fields['PASSWORD'] = NewPasswordContorller.text;
      request.fields['user_id'] = userId;
      request.fields['embedding'] = EmbeddingController.text;
      request.fields['device'] = deviceId;

      if (FaceImageController != null) {
        var imageFile = await http.MultipartFile.fromPath(
            "image", FaceImageController.text);
        request.files.add(imageFile);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['Message'] == 'Success') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('Exception during update_pwd request: $e');
      return false;
    }
  }

  Future update_pwd_user() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance(); //utk ambil id
    String userId =
        prefs.getString('user_id') ?? ''; //ambil user id yg tersimpan

    final deviceService = Getdevice();
    String deviceId = await deviceService.getDeviceId();

    final response = await http.post(
        Uri.parse("http://192.168.100.55/FlutterAPI/update_password_user.php"),
        body: {
          // "id": widget.list[widget.index]["id"],
          "OLD_PASSWORD": passwordController.text,
          "PASSWORD": NewPasswordContorller.text,
          "device": deviceId,
          "user_id": userId,
        });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  forgot_pwd() async {
    final response = await http.post(
      Uri.parse("http://10.233.98.125/FlutterAPI/forgot_password.php"),
      body: {
        "email_address": EmailController.text,
        "PASSWORD": NewPasswordContorller.text
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
