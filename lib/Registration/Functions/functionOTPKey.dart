import 'package:flutter/material.dart';
import 'dart:math';

class functionOTPKey extends StatelessWidget {

  static String GeneratedOTP() {

    String numbers = '123456789';
    String uppers  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    String otpCode = "";

    int otpLenght = 6;

    String format = uppers + numbers;

    List<String> list = format.split('').toList();

    Random formatRandom = Random();

    for (int i = 0; i < otpLenght; i ++) {

      int index = formatRandom.nextInt(list.length);
      otpCode += list[index];
    }
    return otpCode;
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
