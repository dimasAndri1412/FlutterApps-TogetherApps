import 'dart:convert';
import 'package:absent_project/ChangesPasswordPage/ChangesPasswordMenu.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/login/getDevice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../home/ApplicationBar.dart';
import '../home/applicationbar_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';

class LoginController {
  String? alert,
      username,
      password,
      role,
      login_flag,
      IDUsers,
      position,
      device;

  var dataUser;

  final box = GetStorage();

  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userId);
    print('User ID saved: $userId');
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  Future doLogin() async {
    String usernameInput = emailController.text;
    String passwordInput = passwordController.text;
    final deviceService = Getdevice();

    try {
      if (formKey.currentState!.validate()) {
        String deviceId = await deviceService.getDeviceId();
        bool isDeviceLockEnabled = box.read('isDeviceLockEnabled') ?? false;

        var url = Uri.parse("http://192.168.2.159:8080/FlutterAPI/AdminLogin.php");
        // var url = Uri.parse("http://192.168.100.84/FlutterAPI/AdminLogin.php");
        var response = await http.post(url,
            body: {"username": usernameInput, "password": passwordInput});
        dataUser = jsonDecode(response.body);
        print("Status code: ${response.statusCode}");
        print("Response body: ${response.body}");

        if (dataUser.length < 1) {
          alert = "Can't login";
        } else {
          username = dataUser[0]['USERNAME'];
          password = dataUser[0]['PASSWORD'];
          role = dataUser[0]['ROLE'];
          login_flag = dataUser[0]['login_flag'];
          IDUsers = dataUser[0]['ID'];
          position = dataUser[0]['ID'];
          device = dataUser[0]['device'];
        };

        await saveUserId(IDUsers!);

        if (login_flag == "0" && role == "MEMBER" && IDUsers == IDUsers) {
          Get.offAll(() => const ChangesPasswordMenu());
        } else if (login_flag == "1" &&
            role == "MEMBER" &&
            IDUsers == IDUsers) {
          if (isDeviceLockEnabled && device == deviceId) {
            Get.offAll(() => const ApplicationBarUser());
            print("kamu itu member dengan ID = ${IDUsers}");
            /*Get.to(() => const UserHome());*/
          } else if (!isDeviceLockEnabled || device == deviceId) {
            Get.offAll(() => const ApplicationBarUser());
            print('Switch: $isDeviceLockEnabled');
            IdMemberControllers.text = IDUsers!;
          } else {
            SnackBar(
                content: Text(
                    "Your device is different, please login with original device"));
            print(
                'Switch: $isDeviceLockEnabled, Device ID tidak sesuai, batal login \n Device login: $deviceId - Device saved: $device');
          }
        } else if (role == "ADMIN") {
          Get.offAll(() => const ApplicationBar());
        } else if (role == "ADMIN" && position == "Manager") {
          Get.offAll(() => const ApplicationBar());
        } else {
          print("Go to member home page, cuk dengan id = ${IDUsers}");
          /*Get.to(() => const UserHome());*/
        }

        /*  if (role == "admin") {
          Get.offAll(() => const ApplicationBar());
        } else {
          print("Go to member home page, cuk");
          */ /*Get.to(() => const UserHome());*/ /*
        }*/
      } else {
        print("gagal login");
      }
    } catch (Exception) {
      return "Failed Request!";
    }
  }
}
