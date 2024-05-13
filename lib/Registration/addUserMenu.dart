import 'package:absent_project/Registration/addUserHeader.dart';
import 'package:absent_project/Registration/addUserWrapper.dart';
import 'package:absent_project/home/home.dart';
import 'package:absent_project/login/login_page.dart';
import 'package:absent_project/menu/admin/admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class addUserMenu extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromARGB(255, 98, 171, 232),
        leading: IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Admin())),
            icon: Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: Text("REGISTRATION PAGE",
          style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter,colors: [
            Color.fromARGB(255, 145, 201, 247),
            Color.fromARGB(255, 98, 171, 232),
            Color.fromARGB(255, 123, 185, 235),
            Color.fromARGB(255, 255, 255, 255),
          ]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            addUserHeader(),
            Expanded(child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )
              ),
              child: SingleChildScrollView(
                child: addUserWrapper(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
