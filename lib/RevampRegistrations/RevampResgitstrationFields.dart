import 'package:absent_project/MapsViews/MapControllerPages/dropDownListProjectValues.dart';
import 'package:absent_project/MapsViews/MapControllerPages/dropdownListControllers.dart';
import 'package:absent_project/Registration/Functions/fucntionKey.dart';
import 'package:absent_project/RevampRegistrations/materialRewvamp/contollerDropDownResgitration.dart';
import 'package:absent_project/RevampRegistrations/materialRewvamp/dropDownCompanyValues.dart';
import 'package:absent_project/RevampRegistrations/materialRewvamp/dropDownDivionsValues.dart';
import 'package:absent_project/RevampRegistrations/materialRewvamp/dropDownPositionValues.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class revampResgitartionFields extends StatefulWidget {
  const revampResgitartionFields({super.key});

  @override
  State<revampResgitartionFields> createState() => _revampResgitartionFieldsState();
}

class _revampResgitartionFieldsState extends State<revampResgitartionFields> {

  String? dropProjectsValues;
  String? dropDisivionValues;
  String? dropCompanyValues;
  String? dropPositionValues;
  List<Widget> addtionalRegistContainers = [];
  List<dropDownButtonListProjectValue> projectsListings = [];
  List<dropDownDivisionListValues> divisionListings = [];
  List<dropDownPositionValueList> positionListings = [];
  List<dropDownCompanyValuesList> companyListings = [];


  Future<void> getListProjectNames() async {
    final dropDownListValues projectsValues = dropDownListValues();
    final fetchProjects = await projectsValues.getDropDownListProjectValues();
    if (fetchProjects != null) {
      setState(() {
        projectsListings = fetchProjects;
      });
    }
  }

  Future<void> getListPosition() async {
    final dropDownRegistrationList positionValues = dropDownRegistrationList();
    final fetchPosition = await positionValues.getDropDownPositionValues();
    if (fetchPosition != null) {
      setState(() {
        positionListings = fetchPosition;
      });
    }
  }

  Future<void> getListDivision() async {
    final dropDownRegistrationList divionValues = dropDownRegistrationList();
    final fetchDivision = await divionValues.getDivisionListValues();
    if (fetchDivision != null) {
      setState(() {
        divisionListings = fetchDivision;
      });
    }
  }

  Future<void> getListCompany() async {
    final dropDownRegistrationList companyValues = dropDownRegistrationList();
    final fetchCompany = await companyValues.getCompanyListValues();
    if (fetchCompany != null) {
      setState(() {
        companyListings = fetchCompany;
      });
    }
  }


  void addNewsContainers() {
    setState(() {
      Map<String, TextEditingController> controllersss = {
        "revampUserNameController" : TextEditingController(),
        "revampFullNameController" : TextEditingController(),
        "revampBirthDayController" : TextEditingController(),
        "revampAddressController" : TextEditingController(),
        "revampRolesController" : TextEditingController(),
        "revampPasswordController" : TextEditingController(),
        "revampPhoneNumberController" : TextEditingController(),
        "revampEmailController" : TextEditingController(),
        "revampProjectController" : TextEditingController(),
        "revampPositionController" : TextEditingController(),
        "revampDivisionController" : TextEditingController(),
        "revampCompanyController" : TextEditingController(),
      };
      revampResgistControllerss.add(controllersss);
      addtionalRegistContainers.add(buildsRegistContainers(controllersss));
    });
  }

  void removeRegistContainer() {
    setState(() {
      if(addtionalRegistContainers.isNotEmpty) {
        revampResgistControllerss.last.values.forEach((controller) => controller.dispose());
        revampResgistControllerss.removeLast();
        addtionalRegistContainers.removeLast();
      }
    });
  }

  @override
  void dispose() {
    for (var controllersMap in projectControllerss) {
      controllersMap.values.forEach((controller) => controller.dispose());
    }
    super.dispose();
  }

  Widget startBuildRegistContainers(Map<String, TextEditingController> controlersss) {
    return Container(
      key: UniqueKey(),
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: Colors.black26,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Add Registration",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              FloatingActionButton(
                onPressed: addNewsContainers,
                heroTag: null,
                backgroundColor: Colors.blueAccent,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildsRegistContainers(Map<String, TextEditingController> controllersss) {
    return Container(
      key: UniqueKey(),
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: Colors.black26,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller: controllersss["revampFullNameController"],
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
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller: controllersss["revampUserNameController"],
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
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller: controllersss["revampBirthDayController"],
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
                    controllersss["revampBirthDayController"]?.text = formatedDates;
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
              controller: controllersss["revampAddressController"],
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
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: DropdownButtonFormField<String>(
              value: projectsListings.map((project) => project.projectNames).contains(controllersss["revampProjectController"]?.text)
                  ? controllersss["revampProjectController"]?.text
                  : null,
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(
                    "-- Select Your Projects --",
                    style: TextStyle(color: Colors.black26),
                  ),
                ),
                ...projectsListings.map((project) {
                  return DropdownMenuItem(
                    value: project.projectNames,
                    child: Text(project.projectNames),
                  );
                }).toList(),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.work),
              ),
              onChanged: (value) {
                setState(() {
                  String passwordValue = functionKeys.GeneratedPassword();
                  dropProjectsValues = value;
                  if (value != null && value.isNotEmpty) {
                    controllersss["revampRolesController"]?.text = "MEMBER";
                    controllersss["revampPasswordController"]?.text = passwordValue;
                    controllersss["revampProjectController"]?.text = value ?? '';
                  }else {
                    RolesController.clear();
                    PassController.clear();
                  }
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a location";
                }
                return null;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller: controllersss["revampRolesController"],
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
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black87)
                  )
              ),
              child: IntlPhoneField(
                controller: controllersss["revampPhoneNumberController"],
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
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: TextFormField(
              controller: controllersss["revampEmailController"],
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
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: DropdownButtonFormField<String>(
              value: positionListings.map((position) => position.positionNames).contains(controllersss["revampPositionController"]?.text)
                  ? controllersss["revampPositionController"]?.text
                  : null,
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(
                    "-- Select Your Positions --",
                    style: TextStyle(color: Colors.black26),
                  ),
                ),
                ...positionListings.map((position) {
                  return DropdownMenuItem(
                    value: position.positionNames,
                    child: Text(position.positionNames),
                  );
                }).toList(),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.portrait_sharp,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  dropPositionValues = value;
                  if (value != null && value.isNotEmpty) {
                    controllersss["revampPositionController"]?.text = value;
                    print(controllersss["revampPositionController"]?.text);
                  }else {
                    revampPostionController.clear();
                  }
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a Position";
                }
                return null;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: DropdownButtonFormField<String>(
              value: divisionListings.map((division) => division.divisionNames).contains(controllersss["revampDivisionController"]?.text)
                  ? controllersss["revampDivisionController"]?.text
                  : null,
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(
                    "-- Select Your Division --",
                    style: TextStyle(color: Colors.black26),
                  ),
                ),
                ...divisionListings.map((division) {
                  return DropdownMenuItem(
                    value: division.divisionNames,
                    child: Text(division.divisionNames),
                  );
                }).toList(),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.home_work,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  dropCompanyValues = value;
                  if (value != null && value.isNotEmpty) {
                    controllersss["revampDivisionController"]?.text = value;
                  } else {
                    controllersss["revampDivisionController"]?.clear();
                  }
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a Division";
                }
                return null;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black87)
                )
            ),
            child: DropdownButtonFormField<String>(
              value: companyListings.map((company) => company.companyNames).contains(controllersss["revampCompanyController"]?.text)
                  ? controllersss["revampCompanyController"]?.text
                  : null,
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(
                    "-- Select Your Company --",
                    style: TextStyle(color: Colors.black26),
                  ),
                ),
                ...companyListings.map((company) {
                  return DropdownMenuItem(
                    value: company.companyNames,
                    child: Text(company.companyNames),
                  );
                }).toList(),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.home_work,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  dropCompanyValues = value;
                  if (value != null && value.isNotEmpty) {
                    controllersss["revampCompanyController"]?.text = value;
                  } else {
                    controllersss["revampCompanyController"]?.clear();
                  }
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a Company";
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Add Other Registrations",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              FloatingActionButton(
                onPressed: addNewsContainers,
                heroTag: null,
                backgroundColor: Colors.blueAccent,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              SizedBox(width:5),
              FloatingActionButton(
                onPressed: removeRegistContainer,
                heroTag: null,
                backgroundColor: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    getListProjectNames();
    getListPosition();
    getListDivision();
    getListCompany();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 147, 195, 234),
      body: Form(
        key: revampRegistrationsKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                startBuildRegistContainers({
                  "revampUserNameController" : TextEditingController(),
                  "revampFullNameController" : TextEditingController(),
                  "revampBirthDayController" : TextEditingController(),
                  "revampAddressController" : TextEditingController(),
                  "revampRolesController" : TextEditingController(),
                  "revampPasswordController" : TextEditingController(),
                  "revampPhoneNumberController" : TextEditingController(),
                  "revampEmailController" : TextEditingController(),
                  "revampProjectController" : TextEditingController(),
                  "revampPositionController" : TextEditingController(),
                  "revampDivisionController" : TextEditingController(),
                  "revampCompanyController" : TextEditingController(),
                }),
                ...addtionalRegistContainers,
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
      ),
    );
  }
}
