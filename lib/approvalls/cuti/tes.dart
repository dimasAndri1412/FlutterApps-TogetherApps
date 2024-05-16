import 'package:flutter/material.dart';

class SimpleDropDown extends StatefulWidget {
  const SimpleDropDown({super.key});

  @override
  State<SimpleDropDown> createState() => _SimpleDropDownState();
}

class _SimpleDropDownState extends State<SimpleDropDown> {
  List<String> data = [
    "Shift 1",
    "Shift 2",
    "Shift 3"

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
}