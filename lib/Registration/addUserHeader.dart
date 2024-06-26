import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';

class addUserHeader extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: DropShadowImage(
              image: Image.asset('assets/images/Untitled-1.png',
                  width: 165),
              blurRadius: 5,
              scale: 1.05,
            )
          ),
        ],
      ),
    );
  }
}