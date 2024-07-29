import 'package:absent_project/ChangesPasswordPage/ChangesPasswordMenu.dart';
import 'package:absent_project/home/applicationbar_user.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/login/form.dart';
import 'package:absent_project/home/ApplicationBar.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


void main() => runApp(
   const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  )
);

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( 
        padding: const EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 241, 162, 125),
              Color.fromARGB(255, 246, 202, 181),
              Color.fromARGB(255, 145, 201, 247),
              Color.fromARGB(255, 98, 171, 232),
              Color.fromARGB(255, 123, 185, 235),
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
            ]
          )
        ),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 80,),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Image.asset('assets/images/LogoBIT.png', width: 200,),
                      ),
                    ],
                  ),      
                ),
                const SizedBox(height: 20),
                const myForm()
              ],
            )
            )
          ],
        )
      ),
    );
  }
}