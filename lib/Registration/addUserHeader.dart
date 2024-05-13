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
            child: Image.asset('assets/images/Contract.png',
                    width: 150,)
          ),
        ],
      ),
    );
  }
}