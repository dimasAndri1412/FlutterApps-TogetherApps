import 'dart:convert';
import 'package:absent_project/MapsViews/MapControllerPages/dropLocationsList.dart';
import 'package:absent_project/MapsViews/MapControllerPages/dropDownListProjectValues.dart';
import 'package:http/http.dart' as http;

class dropDownListValues {

  Future<List<dropDownButtonListLocationsValues>?> getDropDownLocationValues() async{

    var valueLocation = await http.get(
      Uri.parse(
        "http://192.168.2.159:8080/FlutterAPI/readLocation.php"
      )
    );

    var respDropDownValues = json.decode(
      valueLocation.body
    );

    List<dropDownButtonListLocationsValues> dropDownLisLocationsValues = [];

    for (var l in respDropDownValues) {
      dropDownButtonListLocationsValues listingLocations = dropDownButtonListLocationsValues(
         l['location_name'],
         l['radius'],
         l['latitude'],
         l['longtitude']
      );
       dropDownLisLocationsValues.add(listingLocations);
    }
    return dropDownLisLocationsValues;
  }

  Future<List<dropDownButtonListProjectValue>?> getDropDownListProjectValues() async {

    var valueListProjects = await http.post(
      Uri.parse(
        "http://192.168.2.159:8080/FlutterAPI/readProjectsNew.php"
      )
    );

    var respnDropDownProjects = json.decode(
        valueListProjects.body
    );

    List<dropDownButtonListProjectValue> dropDownListProjects = [];

    for (var p in respnDropDownProjects) {
      dropDownButtonListProjectValue listingProjects = dropDownButtonListProjectValue(
        p['project_name'],
      );

      dropDownListProjects.add(listingProjects);
    }
    return dropDownListProjects;
  }
}