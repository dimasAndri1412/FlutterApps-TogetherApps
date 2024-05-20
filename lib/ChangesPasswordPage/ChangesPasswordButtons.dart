import 'package:flutter/material.dart';

class ChangesPasswordButtons extends StatefulWidget {
  const ChangesPasswordButtons({super.key});

  @override
  State<ChangesPasswordButtons> createState() => _ChangesPasswordButtonsState();
}

class _ChangesPasswordButtonsState extends State<ChangesPasswordButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {},
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
