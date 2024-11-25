import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:absent_project/MapsViews/modelMaps/mapsModels.dart' as gmapsModels;

class findLocationByLatLangControllers {
  var latLangUsers;

  Future findLocationNameByLatlang() async {
    Position currentPositioned = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double latitudeValues = currentPositioned.latitude;
    double longitudeValues = currentPositioned.longitude;

    print(longitudeValues.toString());
    print(latitudeValues.toString());

    try {
      var findQueryLatLang = Uri.parse(
          "http://192.168.2.159:8080/FlutterAPI/findLocationByLatLang.php");

      var LatlangResp = await http.post(
        findQueryLatLang,
        body: {
          'latitude': latitudeValues.toString(),
          'longtitude': longitudeValues.toString(),
        },
      );

      latLangUsers = jsonDecode(LatlangResp.body);

      if (latLangUsers != null && latLangUsers.isNotEmpty) {
        gmapsModels.locationNamesModel = latLangUsers[0]['location_name'];

      } else {
        print("Location name not found");
      }

    } catch (errs) {
      print("Response error: $errs");
    }
  }
}
