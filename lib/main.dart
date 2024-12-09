import 'package:absent_project/controller/AbsentController/ClockInState.dart';
import 'package:absent_project/controller/ApprovalController/NotificationProvider.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/login/LoginPage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ClockInState()),
          ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ],
        child: const GetMaterialApp(
            debugShowCheckedModeBanner: false, home: LoginPage()
            // gmapsClockOutPages(imagePath: 'assets/images/analysis.png',),
            ),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
