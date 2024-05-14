import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class addUserField extends StatefulWidget {
  const addUserField({super.key});

  static final GlobalKey<FormState>formKeys = GlobalKey<FormState>();
  static final GlobalKey<FormState>emailKeys = GlobalKey<FormState>();
  static final GlobalKey<FormState>passKeys = GlobalKey<FormState>();
  static final GlobalKey<FormState>confirmpassKeys = GlobalKey<FormState>();
  static final GlobalKey<FormState>userKeys = GlobalKey<FormState>();
  static final GlobalKey<FormState>birthdateKeys = GlobalKey<FormState>();
  static final GlobalKey<FormState>addressKeys = GlobalKey<FormState>();
  static final GlobalKey<FormState>projectOption = GlobalKey<FormState>();

  static final UserNameController = TextEditingController();
  static final FullNameController = TextEditingController();
  static final AddressController = TextEditingController();
  static final PhoneNumbersController = TextEditingController();
  static final EmailController = TextEditingController();
  static final BirthDateController = TextEditingController();
  static final PassController = TextEditingController();
  static final ConfPassController = TextEditingController();


  @override
  State<addUserField> createState() => _addUserFieldState();
}

class _addUserFieldState extends State<addUserField> {

  TextEditingController dateInput = TextEditingController();
  final userNAmeController = TextEditingController();
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final birthDateController = TextEditingController();
  final passController = TextEditingController();
  final confPassController = TextEditingController();
  bool  passHiding = false;

  String dropDownValues = "";

  var _values = "-1";

  @override
  void iniState(){
    super.initState();
    passHiding = true;
    dateInput.text="";
    dropDownValues = "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Form(
          key: addUserField.formKeys,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide( color: Colors.black87))
                ),
                child: TextFormField(
                  controller: addUserField.FullNameController,
                  decoration: InputDecoration(
                      labelText: "Fullname",
                      hintText: "Please Insert Fullname",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.people)
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username Can not Empty!";
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide( color: Colors.black87))
                ),
                child: TextFormField(
                  controller: addUserField.UserNameController,
                  decoration: InputDecoration(
                      labelText: "UserName",
                      hintText: "Please Insert Username",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.people)
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username Can not Empty!";
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))
                ),
                child: TextFormField(
                  controller: dateInput,
                  decoration: InputDecoration(
                      labelText: "BirthDate",
                      hintText: "Pleas Enter Your BirthDate",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      icon: Icon(Icons.calendar_today)
                  ),
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
                                  foregroundColor: Colors.blueAccent
                                ),
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
                      String formatedDates = DateFormat('yyyy-MM-dd').format(pickedDates);
                      setState(() {
                        dateInput.text = formatedDates;
                      });
                    } else {}
                  },
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "BirtDate Can Not Empty!";
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))
                ),
                child: TextFormField(
                  controller: addUserField.AddressController,
                  decoration: InputDecoration(
                      labelText: "Address",
                      hintText: "Please Insert you address",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.location_city)
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Address Can not Empty!";
                    }
                  },
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black87))
                  ),
                  child: DropdownButtonFormField<String>(
                    value: dropDownValues,
                    items: [
                      DropdownMenuItem( child: Text("--Selected Group--",style: TextStyle(color: Colors.black26),),value: ""),
                      DropdownMenuItem( child: Text("MSDO Project"), value: "1",),
                      DropdownMenuItem( child: Text("Development Project"), value: "2",),
                    ],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.work)),
                    onChanged: (value){
                      setState(() {
                        dropDownValues = value!;
                      });
                    },
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return "Please Select Project";
                      }
                    },
                  )
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))
                ),
                child: IntlPhoneField(
                  controller: phoneNumberController,
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
                    if (value.isBlank! || value == null) {
                      return "Phone Nummber Can not empty";
                    }
                  },
                )
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))
                ),
                child: TextFormField(
                  controller: addUserField.EmailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Please Insert Your Email",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.mail)
                  ),
                  validator: (value) {
                    //validator format email
                    bool inValidEmail = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
                    ).hasMatch(value!);

                    if (value == null || value.isEmpty) {
                      return 'Email Can not empty!';
                    } else if (!inValidEmail) {
                      return "Incorrect Email format";
                    }
                  },
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black87))
                  ),
                  child:TextFormField(
                    obscureText: passHiding,
                    keyboardType: TextInputType.emailAddress,
                    controller: addUserField.PassController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Please Insert your password',
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                            passHiding ? Icons.visibility_off
                                : Icons.visibility),
                        onPressed: () { setState( () {
                          passHiding =!passHiding; },);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password can not empty!';
                      } else if (value.length <= 8) {
                        return 'Password Should be greater than 8 characters';
                      }
                      return null;
                    },
                  )
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black87))
                ),
                child: TextFormField(
                  obscureText: passHiding,
                  keyboardType: TextInputType.emailAddress,
                  controller: addUserField.ConfPassController,
                  decoration: InputDecoration(
                    labelText: ' Confirm Password',
                    hintText: 'Please Insert your password',
                    hintStyle: TextStyle(color: Colors.black26),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          passHiding ? Icons.visibility_off
                              : Icons.visibility),
                      onPressed: () { setState( () {
                        passHiding =!passHiding; },);
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password can not empty!';
                    } else if (value != addUserField.PassController) {
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
