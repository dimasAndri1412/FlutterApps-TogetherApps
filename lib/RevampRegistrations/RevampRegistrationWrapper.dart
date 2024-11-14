import 'package:absent_project/RevampRegistrations/RevampRegistrationButton.dart';
import 'package:absent_project/RevampRegistrations/RevampRegistrationHeader.dart';
import 'package:absent_project/RevampRegistrations/RevampResgitstrationFields.dart';
import 'package:flutter/material.dart';

class revampResgitrationWrapper extends StatefulWidget {
  const revampResgitrationWrapper({super.key});

  @override
  State<revampResgitrationWrapper> createState() => _revampResgitrationWrapperState();
}

class _revampResgitrationWrapperState extends State<revampResgitrationWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 147, 195, 234),
      body: Column(
        children: <Widget>[
          revampRegistrationHeader(),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: revampResgitartionFields()
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 87,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                topLeft: Radius.circular(25.0),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: revampRegistrationButtons(),
          ),
        ],
      ),
    );
  }
}
