//GettingProject
import 'package:absent_project/MapsViews/MatterialMaps/FindMapLocationControllers.dart';
import 'package:absent_project/MapsViews/MatterialMaps/FindProjectControllers.dart';
import 'package:absent_project/MapsViews/modelMaps/usernameModel.dart' as projectsModels;
import 'package:absent_project/MapsViews/modelMaps/mapsModels.dart' as gmapsModels;
import 'package:google_maps_flutter/google_maps_flutter.dart';


//Get Project
Future<String?> findProjectss() async {
  final findsProjectController projectControllers = findsProjectController();
  await projectControllers.findUsers();

  String? valueProject = projectsModels.projectModel;

  final String? valuesProjects = valueProject;
  return valuesProjects;
}

Future<String?> findUserNameLocation() async {
  final findUserNameLocationField = findsProjectController();
  await findUserNameLocationField.findUsers();

  String? valueNameLocation = projectsModels.usersModels;
  return valueNameLocation;
}

Future<String?> findFullNameLocation() async {
  final findFullNamesLocations = findsProjectController();
  await findFullNamesLocations.findUsers();

  String? valueFullNames = projectsModels.fullNameModel;
  return valueFullNames;
}

Future<String?> findAvatarUrl() async {
  final findAvatar = findsProjectController();
  await findAvatar.findUsers();

  String? valueAvatar = projectsModels.avatarModel;
  return valueAvatar;
}

Future<String?> findLocationNames() async {
  try{
    final findGmapsLocation findLocation = findGmapsLocation();
    await findLocation.findLocations();

    final String? bodyLocation = "${gmapsModels.locationNamesModel},${gmapsModels.streetLocationModel}";

    return bodyLocation;

  } catch (err) {
    print(err);
  }
}

//GetRadius
Future<double?> findRadiusLocation() async {
  final findGmapsLocation findRadiusLocations = findGmapsLocation();
  await findRadiusLocations.findLocations();

  double? valueRadiusLocation = double.tryParse(gmapsModels.radiusLocationModel as String);

  final double? radiusLocationValues = valueRadiusLocation;

  print(radiusLocationValues);
  return radiusLocationValues;
}

//getcoordinate
Future<LatLng> coordinateLocation() async {
  final findGmapsLocation findCoordinates = findGmapsLocation();
  await findCoordinates.findLocations();

  double? latitudes = double.tryParse(gmapsModels.latitudeLocationModel as String);
  double? longtitude = double.tryParse(gmapsModels.longTitudeLocationModel as String);

  final LatLng mapsView = LatLng(
      latitudes!,
      longtitude!
  );

  print('latitude location: $latitudes');
  print('longtitdeu location: $longtitude');

  return mapsView;
}