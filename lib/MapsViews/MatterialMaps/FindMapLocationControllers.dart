import 'dart:convert';
import 'package:absent_project/MapsViews/MapsViewPage/GoogleMapsPages.dart';
import 'package:absent_project/MapsViews/MatterialMaps/FindProjectControllers.dart';
import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/MapsViews/modelMaps/usernameModel.dart' as projectsModel;
import 'package:absent_project/MapsViews/modelMaps/mapsModels.dart' as gmapsModels;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class findGmapsLocation {

  String? locationNAmes,streetName,latitudeLocations,longTitudesLocation,radiusLocation;
  var locationUsers;

  Future findLocations() async {

    final findsProjectController findsUsr = findsProjectController();
    await findsUsr.findUsers();

    String? projectNames = projectsModel.projectModel;

    if (projectNames == "Development Project") {
      String locationNamesInput = "intiland tower";

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


    } else if (projectNames == "MSDO Project") {
      String locationNamesInput = "menara brilian";

      try {
        var getLocation = Uri.parse("http://192.168.2.159:8080/FlutterAPI/FindLocation.php");
        var resp = await http.post(
            getLocation,
            body: {
              'location_name': locationNamesInput
            }
        );

        locationUsers = jsonDecode(resp.body);
        gmapsModels.locationNamesModel = locationUsers[0]['location_name'];
        gmapsModels.latitudeLocationModel = locationUsers[0]['latitude'];
        gmapsModels.longTitudeLocationModel = locationUsers[0]['longtitude'];
        gmapsModels.radiusLocationModel = locationUsers[0]['radius'];
        gmapsModels.streetLocationModel = locationUsers[0]['street'];

        String? rdlocation = gmapsModels.radiusLocationModel;

        print('radius location : $rdlocation');

      } catch (err) {
        print(err);
      }
    }
  }
}