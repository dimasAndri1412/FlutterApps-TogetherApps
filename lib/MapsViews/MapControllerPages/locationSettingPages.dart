import 'package:absent_project/MapsViews/MapControllerPages/dropDownListProjectValues.dart';
import 'package:absent_project/MapsViews/MapControllerPages/dropdownListControllers.dart';
import 'package:absent_project/MapsViews/MatterialMaps/insertAddressLocationControllers.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/MapsViews/MapControllerPages/dropLocationsList.dart';
import '../../controller/Keys.dart';

class locationSettingPages extends StatefulWidget {
  const locationSettingPages({super.key});

  @override
  State<locationSettingPages> createState() => _locationSettingPagesState();
}

class _locationSettingPagesState extends State<locationSettingPages> {

  String? dropProjectsValues;
  String? dropLocationProjectvalues;
  List<dropDownButtonListLocationsValues> locationsLists = [];
  List<dropDownButtonListProjectValue> projectsListings = [];
  List<Widget> addtionalContainers = [];
  List<Map<String, TextEditingController>> projectControllers = [];
  bool savedEnabled = false;

  Future<void> getLocationsDatas() async {
    final dropDownListValues locationsValues = dropDownListValues();
    final fetchLocations = await locationsValues.getDropDownLocationValues();
    if (fetchLocations != null) {
      setState(() {
        locationsLists = fetchLocations;
      });
    }
  }

  Future<void> getListProjectNames() async {
    final dropDownListValues projectsValues = dropDownListValues();
    final fetchProjects = await projectsValues.getDropDownListProjectValues();
    if (fetchProjects != null) {
      setState(() {
        projectsListings = fetchProjects;
      });
    }
  }

  void addNewContainers() {
    setState(() {
      Map<String, TextEditingController> controlersss = {
        "projectController": TextEditingController(),
        "locationController": TextEditingController()
      };
      projectControllerss.add(controlersss);
      addtionalContainers.add(buildProjectContainers(controlersss));
    });
    setState(() {
      savedEnabled = true;
    });
  }

  void removeContainers() {
    setState(() {
      if (addtionalContainers.isNotEmpty) {
        projectControllerss.last.values.forEach((controller) => controller.dispose());
        projectControllerss.removeLast();
        addtionalContainers.removeLast();
      }
      if(projectControllerss.isEmpty) {
        savedEnabled = false;
      }
    });
  }

  void insertDataLocAndAdd() async {
    for (var controlersss in projectControllerss) {
      final insertingControllers = insertAddressAndProJectLocationControllers();
      insertingControllers.projectNamesAddrController = controlersss["projectController"]?.text;
      insertingControllers.locationNamesAddrController = controlersss["locationController"]?.text;
      await insertingControllers.insertAddrLocations();
    }
  }

  Widget StartbuildProjectContainers(Map<String, TextEditingController> controlersss) {
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
                "Add Setting Location",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              FloatingActionButton(
                onPressed: addNewContainers,
                heroTag: null,
                backgroundColor: Colors.blueAccent,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              FloatingActionButton(
                onPressed: savedEnabled ? (){
                  if(mapsContollerSettingsKey.currentState!.validate()) {
                    insertDataLocAndAdd();
                    final snackBar = SnackBar(content: Text("Location Save Successfully "));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } : null,
                heroTag: null,
                backgroundColor: savedEnabled ? Colors.green : Colors.grey,
                child: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  //Widget for setting location
  Widget buildProjectContainers(Map<String, TextEditingController> controlersss) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Projects",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.work,
                color: Colors.lightBlue,
                size: 30,
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black87))),
            child: DropdownButtonFormField<String>(
              value: projectsListings.map((project) => project.projectNames).contains(controlersss["projectController"]?.text)
                     ? controlersss["projectController"]?.text
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
                  dropProjectsValues = value;
                  controlersss["projectController"]?.text = value ?? '';
                  print(controlersss["projectController"]?.text);
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
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Location Project",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                Icons.location_on,
                color: Colors.lightBlue,
                size: 30,
              ),
              SizedBox(height: 20),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black87))),
            child: DropdownButtonFormField<String>(
              value: locationsLists.map((locationss) => locationss.locationsNames).contains(controlersss["locationController"]?.text)
                     ? controlersss["locationController"]?.text
                     : null,
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(
                    "-- Select Location --",
                    style: TextStyle(color: Colors.black26),
                  ),
                ),
                ...locationsLists.map((location) {
                  return DropdownMenuItem(
                    value: location.locationsNames,
                    child: Text(location.locationsNames),
                  );
                }).toList(),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.location_pin),
              ),
              onChanged: (value) {
                setState(() {
                  dropLocationProjectvalues = value;
                  controlersss["locationController"]?.text = value ?? '';
                  print(controlersss["locationController"]?.text);
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
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Add Other Location",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              FloatingActionButton(
                onPressed: addNewContainers,
                heroTag: null,
                backgroundColor: Colors.blueAccent,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 15),
              FloatingActionButton(
                onPressed: removeContainers,
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
  void dispose() {
    for (var controllersMap in projectControllerss) {
      controllersMap.values.forEach((controller) => controller.dispose());
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getLocationsDatas();
    getListProjectNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: mapsContollerSettingsKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                StartbuildProjectContainers({
                  "projectController": TextEditingController(),
                  "locationController": TextEditingController(),
                }),
                ...addtionalContainers,
                SizedBox(height: 10),
              ],
            ),
          ),
      )
    );
  }
}
