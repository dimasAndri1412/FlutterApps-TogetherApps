import 'dart:math';

import 'package:flutter/material.dart';

class functionKeys  extends StatelessWidget {

  static String GeneratedPassword() {

    String uppers  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String lowers  = 'abcdefghijklmnopqrstuvwxyz';
    String numbers = '123456789';
    String symbols = '!@#&*';

    String Passwords = "";

    int Passlenght = 10;

    String format = uppers + lowers + numbers + symbols;

    List<String> list = format.split('').toList();

    Random formatRandom = Random();

    for (int i = 0; i < Passlenght; i++) {
      int index = formatRandom.nextInt(list.length);
      Passwords += list[index];
    }
    return Passwords;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
