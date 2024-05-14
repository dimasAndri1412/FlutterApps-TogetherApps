import 'dart:convert';

import 'package:absent_project/controller/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../controller/Keys.dart';
import '../home/ApplicationBar.dart';

class myForm extends StatefulWidget {
  const myForm({super.key});

  @override
  State<myForm> createState() => _myFormState();
}

class _myFormState extends State<myForm> {
  // Future loginAdmin() async{
  //   var url = Uri.parse("http://192.168.100.214/FlutterAPI/AdminLogin.php");
  //   var response = await http.post(url, body:{
  //     "username": emailController.text,
  //     "password": passwordController.text,
  //   });
  //   var data = jsonDecode(response.body);
  //   if(data == "Success") {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const ApplicationBar()),);
  //   }else{
  //     print ("Error cuk");
  //   }
  // }
  bool passwordObscured = true;
  // final _formKey = GlobalKey<FormState>();

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
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Email or Phone Number';
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
                          onPressed: () {},
                          child: const Text('Forgot Password ? '),
                        ),
                        const SizedBox(height: 20,),
                        MaterialButton(
                          // onTap: (){
                          //   check();
                          //    // if (check()) {
                          //    //    Navigator.push(
                          //    //      context,
                          //    //      MaterialPageRoute(builder: (context) => const BottomBar()),
                          //    //    );
                          //    //  }
                          //   },
                          onPressed: () {
                            LoginController().doLogin();
                          },
                          child: Container(
                            // child: Padding(padding: EdgeInsets.all(135)),
                            height: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color.fromARGB(255, 79, 168, 240)
                            ),
                            child: const Center(
                              child: Text(
                                  "Login", style: TextStyle(
                                  color: Colors.white)),
                            ),
                          ),
                        ),
                                   ],
                    )
                  ],
                ),
              ),
            )
        );
  }
}