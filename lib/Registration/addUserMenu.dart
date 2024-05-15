import 'package:absent_project/Registration/addUserHeader.dart';
import 'package:absent_project/Registration/addUserWrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/Keys.dart';
import 'package:get/get.dart';


class addUserMenu extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar : AppBar(
        backgroundColor: Color.fromARGB(255, 98, 171, 232),
        iconTheme: IconThemeData(color: Colors.white),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios,color: Colors.white,),
          onTap: () {
            Navigator.pop(context);
            FullNameController.clear();
            UserNameController.clear();
            BirthDateController.clear();
            AddressController.clear();
            RolesController.clear();
            PhoneNumbersController.clear();
            EmailController.clear();
            PassController.clear();
            ConfPassController.clear();
          },
        ),
        title: Text("PERSONAL INFORMATION",
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


