import 'package:absent_project/Registration/addMenuFlied.dart';
import 'package:flutter/material.dart';
import 'AddUserButton.dart';
import '../controller/Keys.dart';

class addUserWrapper extends StatefulWidget {
  const addUserWrapper({super.key});

  @override
  State<addUserWrapper> createState() => _addUserWrapperState();
}

class _addUserWrapperState extends State<addUserWrapper> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(50),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(60)),
            child: SingleChildScrollView(
              child: addUserField(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          addUserButton()
        ],
      ),
    );
  }
}
