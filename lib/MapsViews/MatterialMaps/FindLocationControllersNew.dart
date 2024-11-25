import 'dart:convert';
import 'package:absent_project/MapsViews/MatterialMaps/FindLocationAndProjectFromAddresControllers.dart';
import 'package:absent_project/MapsViews/MatterialMaps/FindProjectControllers.dart';
import 'package:absent_project/MapsViews/modelMaps/usernameModel.dart' as projectsModel;
import 'package:absent_project/MapsViews/modelMaps/newProjectModels.dart' as projectsLocModel;
import 'package:http/http.dart' as http;

List<String> latitudeList = [];
List<String> longtitudeList = [];
List<String> locationNamesList = [];
List<String> radiusList = [];

class findLocationsControllersNews {
  String? ocationNAmes, streetName, latitudeLocations, longTitudesLocation, radiusLocation;
  var locationNewUsers;

  Future findLocationsNews() async {
    final findLocAndProControllers findProLocs = findLocAndProControllers();
    List<projectsLocModel.newProjecModels> locations = await findProLocs.findProLocations();

    List<String> locationNames = locations.map((location) => location.locationName!).toList();


    try {
      var getLocations = Uri.parse("http://192.168.2.159:8080/FlutterAPI/findLocationsNew.php");

      var locrsp = await http.post(
        getLocations,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'location_name': locationNames
        }),
      );

      if (locrsp.statusCode == 200) {
        locationNewUsers = jsonDecode(locrsp.body);

        if (locationNewUsers is List) {
          for (var location in locationNewUsers) {
            if (location.containsKey('latitude') &&
                location.containsKey('longtitude')) {

              String latitude = location['latitude'].toString();
              String longitude = location['longtitude'].toString();
              String names = location['location_name'].toString();
              String radius = location['radius'].toString();

              latitudeList.add(latitude);
              longtitudeList.add(longitude);
              locationNamesList.add(names);
              radiusList.add(radius);

            }
          }
        }
        return locationNewUsers;
      } else {
        throw Exception("Failed to load new locations");
      }
    } catch (errs) {
      print("Error: $errs");
      return errs;
    }
  }
}
