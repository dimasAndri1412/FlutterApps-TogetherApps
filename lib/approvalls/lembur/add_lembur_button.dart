import 'package:flutter/material.dart';

class addLemburButton extends StatefulWidget {
  const addLemburButton({super.key});

  @override
  State<addLemburButton> createState() => _addLemburButtonState();
}

class _addLemburButtonState extends State<addLemburButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          child: Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 124, 185, 236),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
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
