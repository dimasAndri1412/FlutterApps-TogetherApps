import 'package:flutter/material.dart';

class addCutiButton extends StatefulWidget {
  const addCutiButton({super.key});

  @override
  State<addCutiButton> createState() => _addCutiButtonState();
}

class _addCutiButtonState extends State<addCutiButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          child: Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 124, 185, 236),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text("Submit"),
            ),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
                        )
                      ],
                      title: Text("Your Request Accepted"),
                    ));
          },
        ),
      ],
    );
  }
}
