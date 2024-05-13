import 'package:absent_project/Registration/addUserHeader.dart';
import 'package:absent_project/Registration/addUserWrapper.dart';
import 'package:absent_project/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class addUserMenu extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage())),
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
            Colors.blueAccent,
            Colors.lightBlueAccent,
            Colors.cyan
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
