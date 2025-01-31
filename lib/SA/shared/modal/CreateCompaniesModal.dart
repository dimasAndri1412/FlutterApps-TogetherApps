import 'package:absent_project/SA/json/UsersJson/AddUserJson.dart';
import 'package:absent_project/SA/model/Companies.dart';
import 'package:absent_project/SA/model/Divisions.dart';
import 'package:absent_project/SA/model/Projects.dart';
import 'package:absent_project/SA/model/Users.dart';
import 'package:flutter/material.dart';
import '../../controller/UserController.dart';
import '../../model/Positions.dart';
import '../custom/AddButtonCustom.dart';
import '../custom/TextFormFieldCustom.dart';


class CreateCompaniesModal extends StatefulWidget {

  const CreateCompaniesModal({super.key});

  @override
  State<CreateCompaniesModal> createState() => _CreateModalCompaniesState();
}

class _CreateModalCompaniesState extends State<CreateCompaniesModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _divisionController = TextEditingController();
  final TextEditingController _projectController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  // Instansiasi UserController langsung di sini
  final UserController userController = UserController();
  List<Positions> _positions = [];
  int? _selectedPositionId;

  @override
  void initState(){
    super.initState();
    _fetchPosition();
  }

  Future<void> _fetchPosition() async{
    try{
      List<Positions> positions = await UserController.getPositions();
      setState(() {
        _positions = positions;
      });
    }catch (error){
      print('Failed to load positions: $error');
    }
}

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      AddUserJson addUserJson = AddUserJson(
          login: Users(
              id: null,
              username: _usernameController.text,
              password: _passwordController.text,
              full_name: _fullnameController.text,
              phone_number: _phoneController.text,
              birth_date: _birthdateController.text,
              address: _addressController.text,
              email_address: _emailController.text,
              company_name: null,
              division_name: null,
              project_name: null
          ),
          company: Companies(
              id: null,
              company_name: _companyController.text
          ),
          division: Divisions(
              id: null,
              division_name: _divisionController.text
          ),
          project: Projects(
              project_name: _projectController.text,
              id: null
          ),
          position: Positions(
              id: _selectedPositionId,
              position_name: ""
          )
      );

      UserController.createUser(addUserJson.toJson(), context);
      clearFields();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double modalWidth = constraints.maxWidth;
        double modalHeight = constraints.maxHeight;
        return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * 0.05,
                                  vertical: MediaQuery.of(context).size.height * 0.01),
                              child: Column(
                                children: [
                                  // Company Name
                                  TextFormFieldCustom(
                                    controller: _companyController,
                                    label: "Company Name",
                                    icon: Icons.account_balance,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Company name can't be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10,),
                                  // Division Name
                                  TextFormFieldCustom(
                                    controller: _divisionController,
                                    label: 'Division Name',
                                    icon: Icons.add_card ,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Division name can't be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10,),
                                  // Project Name
                                  TextFormFieldCustom(
                                    controller: _projectController,
                                    label: 'Project Name',
                                    icon: Icons.account_balance_sharp,
                                    isPrefix: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Project name can't be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10,),
                                  // Position Name
                                  DropdownButtonFormField<int>(
                                    value: _selectedPositionId,
                                    hint: const Text("Select Position"),
                                    items: _positions.map((position) {
                                      return DropdownMenuItem<int>(
                                        value: position.id,
                                        child: Text(position.position_name),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedPositionId = value;
                                      });
                                    },
                                    validator: (value) => value == null ? 'Please select a position' : null,
                                  ),
                                  const SizedBox(height: 10,),
                                  // Username
                                  TextFormFieldCustom(
                                    controller: _usernameController,
                                    label: 'Username',
                                    isPrefix: true,
                                    icon: Icons.people ,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Username can't be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10,),
                                  // Password
                                  TextFormFieldCustom(
                                    controller: _passwordController,
                                    label: 'Password',
                                    isPrefix: false,
                                    icon: Icons.visibility,
                                    obsecureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Password can't be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10,),
                                  // Email
                                  TextFormFieldCustom(
                                    controller: _emailController,
                                    label: 'Email',
                                    icon: Icons.email,
                                    validator: (value) {
                                      bool inValidEmail = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value!);
                                      if (value == '' || value.isEmpty) {
                                        return "Email can't be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10,),
                                  // Full Name
                                  TextFormFieldCustom(
                                    controller: _fullnameController,
                                    label: 'Full Name',
                                    icon: Icons.account_box,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Full Name can't be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10,),
                                  // Phone Number
                                  TextFormFieldCustom(
                                    controller: _phoneController,
                                    label: 'Phone Number',
                                    icon: Icons.account_box,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Phone Number can't be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10,),
                                  // Address
                                  TextFormFieldCustom(
                                    controller: _addressController,
                                    label: 'Address',
                                    icon: Icons.account_box,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Address can't be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10,),
                                  // Birth Date
                                  TextFormFieldCustom(
                                    controller: _birthdateController,
                                    label: 'Birth Date',
                                    icon: Icons.account_box,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Birth Date can't be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10,),
                                  // Submit Button
                                  AddButtonCustom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    label: "Submit",
                                    textColor: Colors.white,
                                    backgroundColor: Colors.blueAccent,
                                    onPressed: () {
                                      _submitForm();
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                    )
                  ],
                ),
              )
          )
        );
      },
    );
  }
  void clearFields() {
    _usernameController.clear();
    _passwordController.clear();
    _emailController.clear();
    _fullnameController.clear();
    _companyController.clear();
    _divisionController.clear();
    _projectController.clear();
    _positionController.clear();
    _phoneController.clear();
    _addressController.clear();
    _birthdateController.clear();
  }
}
