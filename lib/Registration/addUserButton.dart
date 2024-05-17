import 'package:absent_project/controller/save_data_controller.dart';
import 'package:flutter/material.dart';
import '../controller/Keys.dart';

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
            if (formKeys.currentState!.validate()) {
              ctr_data().savefunc().then((value) {
                if (value) {
                  final snackBar = SnackBar(
                    content: const Text('Data Berhasil Disimpan'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  ctr_data().clear_func();
                } else {
                  final snackBar = SnackBar(
                    content: const Text('Data Gagal Disimpan'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              });

              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => testPagesNew()));
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
                child: Text(
                  'SAVE',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ],
    );
  }
}
