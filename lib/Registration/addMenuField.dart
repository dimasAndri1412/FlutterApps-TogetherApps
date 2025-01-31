import 'package:absent_project/Registration/Functions/fucntionKey.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../controller/Keys.dart';

class addUserField extends StatefulWidget {
  const addUserField({super.key});

  @override
  State<addUserField> createState() => _addUserFieldState();
}

class _addUserFieldState extends State<addUserField> {
  bool passHiding = true;
  String dropDownValues = "";

  @override
  void iniState() {
    super.initState();
    BirthDateController.text = "";
    dropDownValues = "";
  }

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
                        value: "MSDO Project",
                      ),
                      DropdownMenuItem(
                        child: Text("Development Project"),
                        value: "Development Project",
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
                          ProjectController.text = value;
                        } else {
                          RolesController.clear();
                          PassController.clear();
                        }
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Select Project";
                      }
                      return null;
                    },
                  )),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))),
                child: TextFormField(
                  controller: RolesController,
                  readOnly: true,
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
                  readOnly: true,
                  decoration: InputDecoration(
                      labelText: "Project",
                      hintText: "Please Insert Project",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.people)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Roles Can not Project!";
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
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))),
                child: TextFormField(
                  controller: EmailController,
                  decoration: const InputDecoration(
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
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black87))),
                  child: TextFormField(
                    obscureText: passHiding,
                    controller: PassController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Please Insert your password',
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock),
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
