import 'package:absent_project/MapsViews/MapControllerPages/dropDownListProjectValues.dart';
import 'package:absent_project/MapsViews/MapControllerPages/dropLocationsList.dart';
import 'package:flutter/material.dart';

class addPagesDropDown extends StatefulWidget {
  const addPagesDropDown({super.key});

  @override
  State<addPagesDropDown> createState() => _addPagesDropDownState();
}

class _addPagesDropDownState extends State<addPagesDropDown> {

  String? dropProjectsValues;
  String? dropLocationProjectvalues;
  List<dropDownButtonListLocationsValues> locationsLists = [];
  List<dropDownButtonListProjectValue> projectsListings = [];

  Widget addDropDownpgs() {
    return Container(
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
                "Select Project",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.work, color: Colors.lightBlue, size: 30),
            ],
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: dropProjectsValues,
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
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select a location";
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Location Project",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.location_on, color: Colors.lightBlue, size: 30),
            ],
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: dropLocationProjectvalues,
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
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select a location";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
