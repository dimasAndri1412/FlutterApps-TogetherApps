import 'package:flutter/material.dart';

class addUserHeader extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text("PERSONAL DATA",
              style: TextStyle(
                  color: Colors.white ,
                  fontSize: 16,
                  fontWeight:
                  FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}