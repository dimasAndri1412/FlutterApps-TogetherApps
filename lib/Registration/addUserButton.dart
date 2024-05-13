import 'package:flutter/material.dart';
import 'addMenuFlied.dart';
import 'newPages.dart';

class addUserButton extends StatefulWidget {
  const addUserButton({super.key});

  @override
  State<addUserButton> createState() => _addUserButtonState();
}

class _addUserButtonState extends State<addUserButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (addUserField.formKeys.currentState!.validate()) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => testPagesNew()));
            }
          },
          child: Container(
              height: 50,
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text('SAVE',style: TextStyle(
                    color: Colors.white,
                    fontSize: 15, fontWeight: FontWeight.bold),),
              )
          ),
        ),
      ],
    );
  }
}
