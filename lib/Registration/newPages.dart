import 'package:absent_project/Registration/addUserMenu.dart';
import 'package:absent_project/login/login_page.dart';
import 'package:flutter/material.dart';

class testPagesNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Dims Apps',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => addUserMenu())),
            icon: Icon(Icons.arrow_back, color: Colors.white,),
          ),
          title: Text('Welcome To My Apps',
            style: TextStyle(color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Text('Hai Everyone,Welcome',
            style: TextStyle(color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}