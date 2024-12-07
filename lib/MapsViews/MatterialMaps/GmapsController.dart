//GettingProject
import 'dart:async';
import 'package:absent_project/MapsViews/MatterialMaps/FindLastLogOutControllers.dart';
import 'package:absent_project/MapsViews/MatterialMaps/FindLocationByLatLangController.dart';
import 'package:absent_project/MapsViews/MatterialMaps/FindLocationControllersNew.dart';
import 'package:absent_project/MapsViews/MatterialMaps/FindMapLocationControllers.dart';
import 'package:absent_project/MapsViews/MatterialMaps/FindNewProjectControllers.dart';
import 'package:absent_project/MapsViews/MatterialMaps/FindProjectControllers.dart';
import 'package:absent_project/MapsViews/MatterialMaps/findPositionNameControllers.dart';
import 'package:absent_project/MapsViews/MatterialMaps/findProjectNamesNew.dart';
import 'package:absent_project/MapsViews/MatterialMaps/findShifClockInController.dart';
import 'package:absent_project/MapsViews/MatterialMaps/validationDatesForClockIn.dart';
import 'package:absent_project/MapsViews/MatterialMaps/validationLocationName.dart';
import 'package:absent_project/MapsViews/modelMaps/usernameModel.dart' as projectsModels;
import 'package:absent_project/MapsViews/modelMaps/mapsModels.dart' as gmapsModels;
import 'package:absent_project/MapsViews/modelMaps/clockOutModels.dart' as clockOutModels;
import 'package:absent_project/MapsViews/modelMaps/lastLogOutsModels.dart' as lastClockOutModel;
import 'package:absent_project/MapsViews/modelMaps/validateModels.dart' as validationModels;
import 'package:absent_project/MapsViews/modelMaps/newLocationProjectModels.dart' as newProjectsModels;
import 'package:absent_project/MapsViews/modelMaps/validasiModels.dart' as validationsModels;
import 'package:absent_project/MapsViews/modelMaps/validateModels.dart' as validationModels;
import 'package:absent_project/controller/verifyPasswordLogin.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


//Get Project
Future<String?> findProjectss() async {
  final findLocationsControllersNews controllerProjects = findLocationsControllersNews();
  await controllerProjects.findLocationsNews();

  String? projectsNamesValues = newProjectsModels.projectNamesLocations;
  return projectsNamesValues;
}

Future<String?> findProjectNamesNews() async {
  final findNewProjectsControllers projectNames = findNewProjectsControllers();
  await projectNames.findLocationsNamesNew();
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
    final findGmapsLocation controllers = findGmapsLocation();
    await controllers.findLocations();

    String? locationValues = gmapsModels.locationNamesModel;

    final String? locationNamesValues = locationValues;

    return locationNamesValues!;

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
  return mapsView;
}

//getLangtitudeOnly
Future<double?> findLatitudeOnly() async {
  final findGmapsLocation findLatitudeOnly = findGmapsLocation();
  await findLatitudeOnly.findLocations();

  double? latitudes = double.parse(gmapsModels.latitudeLocationModel as String);
  return latitudes;
}

//getLongtitudeOnly
Future<double?> findLongtitudeOnly() async {
  final findGmapsLocation findLongtitudeOnlys = findGmapsLocation();
  await findLongtitudeOnlys.findLocations();

  double? longitudes = double.parse(gmapsModels.longTitudeLocationModel as String);
  return longitudes;
}

Future<String?> findLastLogIns() async {
  final findLastLogOutControllerss = findLastLogOutControllers();
  await findLastLogOutControllerss.findLogOuts();

  String? lastLogOutsValue = 'last log : ${lastClockOutModel.lastClockOuts}';
  return lastLogOutsValue;
}

Future<String?> findVerifyLocationName() async {
  final verifyLocatioName = validatioLocationName();
  await verifyLocatioName.verfiyLocationName();

  String? locationNameValues = validationsModels.validationLocationNames;
  return locationNameValues;
}

Future<String?> findShiftClockIn() async {
  final findShiftValue = findClockOutControllers();
  await findShiftValue.findClockInValues();

  String? valueShift = clockOutModels.shiftCLockOutModels;
  return valueShift;
}

Future<String?> findClockInTimes() async {
  final findClockInValue = findClockOutControllers();
  await findClockInValue.findClockInValues();

  String? valueClockIN = clockOutModels.ClockInTimeCLockOutModels;
  return valueClockIN;
}

Future<String?> findLastClockIn() async {
  final findClockInValues = verifyDateClockIn();
  await findClockInValues.verifyClockIn();

  String? valueClockIns = validationModels.validateClockInModels;
  return valueClockIns;
}

//findLatitudeOnlyNew
Future<List<double?>> revampFindLatitudesOnly() async {
  try{
    final findLocationsControllersNews findLatitudeOnlys = findLocationsControllersNews();
    await findLatitudeOnlys.findLocationsNews();

    List<double?> latitudeListing = [];

    for (int i = 0; i < latitudeList.length; i++) {
      double? latitudes = double.tryParse(latitudeList[i]);
      if (latitudes != null) {
        latitudeListing.add(latitudes);
      }
    }
    return latitudeListing;
  } catch(errs) {
    print(errs);
  }
  return [];
}

//findLongtitudeOnlyNew
Future<List<double?>> revampFindLongtitudeOnly() async {
  try{
    final findLocationsControllersNews findLongtitudeOnly = findLocationsControllersNews();
    await findLongtitudeOnly.findLocationsNews();

    List<double?> longtitudeListing = [];
    for (int i = 0; i < latitudeList.length; i++) {
      double? longtitudes = double.tryParse(longtitudeList[i]);

      if (longtitudes != null) {
        longtitudeListing.add(longtitudes);
      }
    }
    return longtitudeListing;
  } catch(errs) {
    print(errs);
  }
  return [];
}

//findRadiusOnlyNew
Future<List<double?>> revampFindRadiusOnly() async {
  try{
    final findLocationsControllersNews findRadiusOnly = findLocationsControllersNews();
    await findRadiusOnly.findLocationsNews();

    List<double?> radiusListing = [];

    for (int i = 0; i < latitudeList.length; i++) {
      double? radius = double.tryParse(radiusList[i]);

      if(radius != null) {
        radiusListing.add(radius);
      }
    }
    return radiusListing;
  } catch(errs) {
    print(errs);
  }
  return [];
}

//findLocationNames
Future<List<String?>> revampFindLocationsNamesNews() async{
  try{
    final findLocationsControllersNews findLocationNamesOnly = findLocationsControllersNews();
    await findLocationNamesOnly.findLocationsNews();

    List<String?> locationNamesListing = [];

    for (int i = 0; i < latitudeList.length; i++) {
      String? locationNamesNewOnly = locationNamesList[i];

      if (locationNamesNewOnly != null){
        locationNamesListing.add(locationNamesNewOnly);
      }
    }
    return locationNamesListing;
  } catch(errs) {
    print('error : $errs');
  }
  return [];
}

//findRadiusNews
Future<List<Map<String, dynamic>>> findRadiusLocationNew() async {
  try {
    final findLocationsControllersNews findRadiusNew = findLocationsControllersNews();
    await findRadiusNew.findLocationsNews();

    List<Map<String,dynamic>> locationRadius = [];

    for (int i = 0; i < latitudeList.length; i++) {
      double? latitudes = double.tryParse(latitudeList[i]);
      double? longtitudes = double.tryParse(longtitudeList[i]);
      double? radius = double.tryParse(radiusList[i]);

      if (latitudes != null && longtitudes != null && radius != null) {
        locationRadius.add({
          "coordinate": LatLng(
            latitudes,
            longtitudes
          ),
          "radius": radius
        });
      }
    }

    return locationRadius;

  } catch(errs) {
    print(errs);
    return [];
  }
}

Future<String?> revampLocationNameForLocationNameField() async {
  try{
    final findLocationByLatLangControllers latLangControllerss = findLocationByLatLangControllers();
    await latLangControllerss.findLocationNameByLatlang();

    String? nameValues = gmapsModels.locationNamesModel;
    final locationNameValues = nameValues;

    return locationNameValues;

  }catch(errors) {
    print("error message : $errors");
  }
}

//coordinateNew
Future<List<LatLng>> coordinateLocatioNew() async {
  final findLocationsControllersNews findCoordinates = findLocationsControllersNews();
  await findCoordinates.findLocationsNews();

  List<LatLng> mapsViewCoordinates = [];

  for (int i = 0; i < latitudeList.length; i++) {
    double? latitudes = double.tryParse(latitudeList[i]);
    double? longtitudes = double.tryParse(longtitudeList[i]);

    if (latitudes != null && longtitudes != null) {
      mapsViewCoordinates.add(
          LatLng(
              latitudes,
              longtitudes
          )
      );
    }
  }

  return mapsViewCoordinates;
}

Future<String?> findPositionName() async {
  final findPositionControllers positionNames = findPositionControllers();
  await positionNames.findPositionNames();

  String? positionNameValues = projectsModels.positionNames;
  return positionNameValues;
}

Future<String?> findNewProjectName() async {
  final FindProjectNamesControllers projectNames = FindProjectNamesControllers();
  await projectNames.findProjectNameNews();

  String? projectNameValues = projectsModels.projectNames;
  return projectNameValues;
}

Future<String?>verifyPasswordControllers() async {
  final VerifyPasswordValue inputPassword = VerifyPasswordValue();
  await inputPassword.verifyPassowrd();

  String? passwordValues = validationModels.validatePassword;
  return passwordValues;

}