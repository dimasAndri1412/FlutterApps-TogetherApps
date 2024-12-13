import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/OTPVerfication/OTPVerficationPage.dart';
import 'package:absent_project/controller/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Keys.dart';

class myForm extends StatefulWidget {
  const myForm({super.key});

  @override
  State<myForm> createState() => _myFormState();
}

class _myFormState extends State<myForm> {

  bool passwordObscured = true;

  void loginVerified() async {
    final validateUserNames = await verifyUserNames();
    final validatePassword = await verifiedPassword();

    // Handle null values safely
    if (validateUserNames == null || validatePassword == null) {
      final snackBar = SnackBar(
        content: Text("Login data is missing, please check your input."),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      emailController.clear();
      passwordController.clear();
      return;
    }

    loginPasswordValidateControllers.text = validatePassword;
    loginUserNamesValidateControllers.text = validateUserNames;

    if ((emailController.text == loginUserNamesValidateControllers.text && validateUserNames.isNotEmpty) &&
        (passwordController.text == loginPasswordValidateControllers.text && validatePassword.isNotEmpty)) {

      loginPasswordValidateControllers.clear();
      loginUserNamesValidateControllers.clear();
      LoginController().doLogin();

      final snackBar = SnackBar(content: Text("Login Successfully"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    } else {
      final snackBar = SnackBar(
        content: Text("Your Password or User Names is incorrect! Please try again."),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      loginPasswordValidateControllers.clear();
      loginUserNamesValidateControllers.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(60),
                  topRight: Radius.circular(60))
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30,),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(
                            color: Color.fromARGB(255, 147, 195, 234),
                            blurRadius: 15,
                            offset: Offset(2, 10)
                        )
                        ]
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, top: 5),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))
                            ),
                            child: TextFormField(
                              controller: emailController,
                              validator: (value) {
                                bool inValidEmail = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
                                ).hasMatch(value!);
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Email or Phone Number';
                                } else if (value.isNotEmpty) {
                                  emailController.text;
                                } else if (inValidEmail){
                                  emailController.clear();
                                  return 'Please Insert valid email format';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5),
                                  icon: Icon(
                                    Icons.person, color: Colors.grey,),
                                  hintText: "Email or Phone Number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                              ),
                              onChanged: (value){
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, top: 5),
                            child: TextFormField(
                              controller: passwordController,
                              validator: (value) {

                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Password';
                                }
                                return null;
                              },
                              obscureText: passwordObscured,
                              onChanged: (value){

                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 5, top: 10),
                                  icon: const Icon(
                                    Icons.lock, color: Colors.grey,),
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordObscured =
                                        !passwordObscured;
                                      });
                                    },
                                    icon: Icon(
                                        passwordObscured ?
                                        Icons.visibility_off : Icons
                                            .visibility
                                    ),
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  // Button
                ),
                const SizedBox(height: 20,),
                Column(
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Get.offAll(() => OTPVerficationPage());
                        });
                      },
                      child: const Text(''
                          'Forgot Password ?',
                           style: TextStyle(
                             color: Colors.blue,
                             fontWeight: FontWeight.normal,
                             fontSize: 15
                           ),
                      ),
                    ),
                    const SizedBox(height: 30,
                    ),
                    FloatingActionButton.extended (
                        onPressed: () {
                          if(formKey.currentState!.validate()) {
                            loginVerified();
                          }
                        },
                      backgroundColor: Colors.blueAccent,
                      label: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      icon: Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
  @override
  void dispose(){
    super.dispose();
  }
}