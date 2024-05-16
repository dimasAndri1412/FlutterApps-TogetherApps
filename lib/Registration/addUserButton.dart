import 'package:flutter/material.dart';
import 'addMenuFlied.dart';
import 'newPages.dart';
import '../controller/Keys.dart';
import 'package:http/http.dart' as http;

_simpan() async {
  final response = await http.post(
    Uri.parse("http://192.168.2.159/FlutterAPI/create.php"),
    body: {
      "full_name": FullNameController.text,
      "USERNAME": UserNameController.text,
      "birth_date": BirthDateController.text,
      "address": AddressController.text,
      // "grup": addUserField.grupController.text,
      "ROLE": RolesController.text,
      "phone_number": PhoneNumbersController.text,
      "email_address": EmailController.text,
      "PASSWORD": PassController.text
    },
  );
}

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
              _simpan().then((value) {
                if (value) {
                  final snackBar = SnackBar(
                    content: const Text('Data Berhasil Disimpan'),
                  );
                } else {
                  final snackBar = SnackBar(
                    content: const Text('Data Gagal Disimpan'),
                  );
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
