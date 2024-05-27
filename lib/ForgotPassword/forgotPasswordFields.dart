import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';

class forgotPasswordField extends StatefulWidget {
  const forgotPasswordField({super.key});

  @override
  State<forgotPasswordField> createState() => _forgotPasswordFieldState();
}

class _forgotPasswordFieldState extends State<forgotPasswordField> {

  bool passHides = true;

  @override
  Widget build(BuildContext context) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Form(
            key: formsForgotKeys,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black87)
                      )
                  ),
                  child: TextFormField(
                    controller: FullNameController,
                    decoration: InputDecoration(
                        labelText: "FullName",
                        hintText: "Please Insert FullName",
                        hintStyle: TextStyle(
                          color: Colors.black12,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "UserName can not empty!";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black87)
                    )
                  ),
                  child: TextFormField(
                    controller: UserNameController,
                    decoration: InputDecoration(
                      labelText: "UserName",
                      hintText: "Please Insert UserName",
                      hintStyle: TextStyle(
                        color: Colors.black12,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "UserName can not empty!";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black87))),
                  child: TextFormField(
                    controller: EmailController,
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Please Insert Your Email",
                        hintStyle: TextStyle(color: Colors.black26),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.mail)),
                    validator: (value) {
                      //validator format email
                      bool inValidEmail = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);

                      if (value == null || value.isEmpty) {
                        return 'Email Can not empty!';
                      } else if (!inValidEmail) {
                        EmailController.clear();
                        return "Incorrect Email format";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Colors.black87))),
                  child: TextFormField(
                    controller: NewPasswordContorller,
                    obscureText: passHides,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "New Password",
                        hintText: "Please Insert your New password",
                        hintStyle: TextStyle(
                          color: Colors.black12,
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(passHides
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passHides = !passHides;
                            });
                          },
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password Can not Empty!";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Colors.black87))),
                  child: TextFormField(
                    controller: ConfPassController,
                    obscureText: passHides,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "New Confirm Password",
                        hintText: "Please Insert your New Confirm password",
                        hintStyle: TextStyle(
                          color: Colors.black12,
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(passHides
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passHides = !passHides;
                            });
                          },
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password Can not Empty!";
                      } else if (value != NewPasswordContorller.text) {
                        return "Password it's not match!";
                      }
                    },
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
