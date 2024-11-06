import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeController.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/approvalls/lembur/msdo/pengajuan_lembur.dart';
import 'package:absent_project/controller/Keys.dart';

class addLemburButton extends StatefulWidget {
  const addLemburButton({super.key});

  @override
  State<addLemburButton> createState() => _addLemburButtonState();
}

class _addLemburButtonState extends State<addLemburButton> {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // final formKey = GlobalKey<FormState>();

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
            if (formOTKey.currentState!.validate() ||
                    formOTKeyShifting.currentState!.validate() ??
                false) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Form Approved'),
                    content: Text('The form has been submit !'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          MemberRequestOvertimeController().save();
                          Navigator.of(context).pop();
                          MemberRequestOvertimeController().clearInfo();
                          //MemberRequestOvertimeController().clearInfo();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Form is not valid')),
              );
            }
          },
        ),
      ],
    );
  }
}


///////////////////////

// import 'package:flutter/material.dart';

// class addLemburButton extends StatefulWidget {
//   final GlobalKey<FormState> formKey;

//   const addLemburButton({required this.formKey, Key? key}) : super(key: key);

//   @override
//   State<addLemburButton> createState() => _addLemburButtonState();
// }

// class _addLemburButtonState extends State<addLemburButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         MaterialButton(
//           child: Container(
//             height: 40,
//             width: 200,
//             decoration: BoxDecoration(
//               color: const Color.fromARGB(255, 124, 185, 236),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Center(
//               child: Text(
//                 "Submit",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//           onPressed: () {
//             if (widget.formKey.currentState?.validate() ?? false) {
//               // Jika form valid, lakukan sesuatu
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Form is valid')),
//               );
//             } else {
//               // Jika form tidak valid, tampilkan pesan error
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Form is not valid')),
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
