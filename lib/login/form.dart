import 'package:flutter/material.dart';
// import 'package:first_project/login/button.dart';
import 'package:absent_project/home/bar.dart';

final _formKey = GlobalKey<FormState>();

class myForm extends StatefulWidget {
  const myForm({super.key});

  @override
  State<myForm> createState() => _myFormState();
}

class _myFormState extends State<myForm> {
   bool passwordObscured = true; 

  @override
  Widget build(BuildContext context) {
    return Expanded(  
        child: Container(
        decoration:  const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
        ),
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow:  [BoxShadow(
                    color:    Color.fromARGB(255, 147, 195, 234),
                    blurRadius: 15,
                    offset: Offset(2,10)
                  )]
                ),
                child: Form(
                  key:_formKey,
                  child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email or Phone Number';
                            }
                            return null;
                          },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5),
                          icon: Icon(Icons.person, color: Colors.grey,),
                          hintText: "Email or Phone Number",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                            }
                            return null;
                          },
                        obscureText: passwordObscured,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5, top: 10),
                          icon: Icon(Icons.lock, color: Colors.grey,),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                passwordObscured = !passwordObscured;
                              });
                            },
                            icon: Icon(
                              passwordObscured ? 
                              Icons.visibility_off : Icons.visibility
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
              SizedBox(height: 20,),
              Column(
                children: <Widget>[
                    TextButton(
                      onPressed: (){},
                      child: Text('Forgot Password ? '),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){
                        if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const BottomBar()),
                            );
                          }
                        },
                      child: Container(
                      // child: Padding(padding: EdgeInsets.all(135)),
                          height: 60,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 79, 168, 240)
                          ),
                          child: Center(
                            child: Text(
                              "Login", style: TextStyle(color: Colors.white)),
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