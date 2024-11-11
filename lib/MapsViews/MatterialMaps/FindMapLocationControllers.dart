import 'dart:convert';
import 'package:absent_project/MapsViews/MatterialMaps/FindNewProjectControllers.dart';
import 'package:absent_project/MapsViews/modelMaps/mapsModels.dart' as gmapsModels;
import 'package:absent_project/MapsViews/modelMaps/newLocationProjectModels.dart' as newProjectsModels;
import 'package:http/http.dart' as http;


class findGmapsLocation {

  String? locationNAmes,streetName,latitudeLocations,longTitudesLocation,radiusLocation;
  var locationUsers;

  Future findLocations() async {

    final findNewProjectsControllers findsUsr = findNewProjectsControllers();
    await findsUsr.findLocationsNamesNew();

    String? locationNamesInput = newProjectsModels.locationNamesProjects;

    try{

      var getLocation = Uri.parse("http://192.168.2.159:8080/FlutterAPI/FindLocation.php");
      var resp = await http.post(
          getLocation,
          body: {
            'location_name' : locationNamesInput
          }
      );

      locationUsers = jsonDecode(resp.body);
      gmapsModels.locationNamesModel = locationUsers[0]['location_name'];
      gmapsModels.latitudeLocationModel = locationUsers[0]['latitude'];
      gmapsModels.longTitudeLocationModel = locationUsers[0]['longtitude'];
      gmapsModels.radiusLocationModel = locationUsers[0]['radius'];
      gmapsModels.streetLocationModel = locationUsers[0]['street'];


    } catch (err) {
      print(err);
    }
  }
}