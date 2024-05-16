import 'package:absent_project/Registration/Functions/fucntionKey.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import '../controller/Keys.dart';

class addUserField extends StatefulWidget {
  const addUserField({super.key});

  @override
  State<addUserField> createState() => _addUserFieldState();
}

class _addUserFieldState extends State<addUserField> {
  bool passHiding = false;

  String dropDownValues = "";

  @override
  void iniState() {
    super.initState();
    passHiding = true;
    BirthDateController.text = "";
    dropDownValues = "";
  }



  List<String> projects = [
    "MSDO Projects",
    "Development Projects"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Form(
          key: formKeys,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))),
                child: TextFormField(
                  controller: FullNameController,
                  decoration: InputDecoration(
                      labelText: "Fullname",
                      hintText: "Please Insert Fullname",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.people)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username Can not Empty!";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))),
                child: TextFormField(
                  controller: UserNameController,
                  decoration: InputDecoration(
                      labelText: "UserName",
                      hintText: "Please Insert Username",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.people)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username Can not Empty!";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))),
                child: TextFormField(
                  controller: BirthDateController,
                  decoration: InputDecoration(
                      labelText: "BirthDate",
                      hintText: "Pleas Enter Your BirthDate",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      icon: Icon(Icons.calendar_today)),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDates = await showDatePicker(
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                  primary: Colors.lightBlue,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.blueAccent),
                              ),
                            ),
                            child: child!,
                          );
                        },
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));

                    if (pickedDates != null) {
                      String formatedDates =
                          DateFormat('yyyy-MM-dd').format(pickedDates);
                      setState(() {
                        BirthDateController.text = formatedDates;
                      });
                    } else {}
                  },
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "BirtDate Can Not Empty!";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))),
                child: TextFormField(
                  controller: AddressController,
                  decoration: InputDecoration(
                      labelText: "Address",
                      hintText: "Please Insert you address",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.location_city)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Address Can not Empty!";
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
                  child: DropdownButtonFormField<String>(
                    value: dropDownValues,
                    items: [
                      DropdownMenuItem(
                          child: Text(
                            "--Selected Group--",
                            style: TextStyle(color: Colors.black26),
                          ),
                          value: ""),
                      DropdownMenuItem(
                        child: Text("MSDO Project"),
                        value: "1",
                      ),
                      DropdownMenuItem(
                        child: Text("Development Project"),
                        value: "2",
                      ),
                    ],
                    decoration: InputDecoration(
                        border: InputBorder.none, prefixIcon: Icon(Icons.work)),
                    onChanged: (value) {
                      setState(() {
                        String passwordValue = functionKeys.GeneratedPassword();
                        dropDownValues = value!;
                        if (value.isNotEmpty) {
                          RolesController.text = "MEMBER";
                          PassController.text = passwordValue;
                        } else if (value == "1") {
                          ProjectController.text = "MSDO Project";
                        } else if (value == "2") {
                          ProjectController.text = "Development Project";
                        } else {
                          RolesController.clear();
                          PassController.clear();
                          ProjectController.clear();
                        }
                      }
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Select Project";
                      }
                      return null;
                    },
                  )
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                    Border(bottom: BorderSide(color: Colors.black87))),
                child: DropDownField(
                  
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))),
                child: TextFormField(
                  controller: RolesController,
                  decoration: InputDecoration(
                      labelText: "Roles",
                      hintText: "Please Insert Roles",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.people)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Roles Can not Empty!";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))),
                child: TextFormField(
                  controller: ProjectController,
                  decoration: InputDecoration(
                      labelText: "Project",
                      hintText: "Please Insert project",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.people)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Project Can not Empty!";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black87))),
                  child: IntlPhoneField(
                    controller: PhoneNumbersController,
                    keyboardType: TextInputType.phone,
                    focusNode: FocusNode(),
                    dropdownTextStyle: TextStyle(fontSize: 18),
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: "Please insert you phone nummber",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                    ),
                    initialCountryCode: 'ID',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    validator: (value) {
                      if (value == null || value.completeNumber.isEmpty) {
                        return "Phone Nummber Can not empty";
                      }
                      return null;
                    },
                  )),
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
                    obscureText: passHiding,
                    keyboardType: TextInputType.emailAddress,
                    controller: PassController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Please Insert your password',
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(passHiding
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(
                            () {
                              passHiding = !passHiding;
                            },
                          );
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password can not empty!';
                      } else if (value.length < 8) {
                        PassController.clear();
                        return 'Password Should be greater than 8 characters';
                      }
                      return null;
                    },
                  )),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))),
                child: TextFormField(
                  obscureText: passHiding,
                  keyboardType: TextInputType.emailAddress,
                  controller: PassController,
                  decoration: InputDecoration(
                    labelText: ' Confirm Password',
                    hintText: 'Please Insert your password',
                    hintStyle: TextStyle(color: Colors.black26),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          passHiding ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(
                          () {
                            passHiding = !passHiding;
                          },
                        );
                      },
                    ),
                  ),
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Password can not empty!';
                     } else if (value != PassController.text) {
                       ConfPassController.clear();
                       return "Sorry Password Not Match!";
                     }
                     return null;
                   },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}


