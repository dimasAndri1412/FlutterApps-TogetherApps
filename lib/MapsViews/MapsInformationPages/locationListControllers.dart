import 'dart:async';
import 'dart:convert';
import 'package:absent_project/MapsViews/MapsInformationPages/locationList.dart';
import 'package:http/http.dart' as http;

class listLocationsContollers {

  Future<List<listLocations>?> getListLocations() async {
    try {
      var dataLocation = await http.get(
          Uri.parse("http://192.168.2.159:8080/FlutterAPI/readLocation.php")
      );

      if (dataLocation.statusCode == 200) {
        var respDataLocation = json.decode(dataLocation.body);

        if (respDataLocation == null || respDataLocation.isEmpty) {
          return [];
        }

        List<listLocations> locationsListing = [];
        for (var l in respDataLocation) {
          listLocations location = listLocations(
            l['location_name'],
            l['street'],
            l['locality'],
            l['sublocality'],
            l['city'],
            l['subcity'],
            l['postal_code'],
            l['radius'],
            l['latitude'],
            l['longtitude'],
            l['location_pgs'],
          );
          locationsListing.add(location);
        }
        return locationsListing;
      } else {
        print("Gagal memuat data lokasi, status code: ${dataLocation.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error saat mengambil data lokasi: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>> deleteLocation(String locationNames) async {
    var respns = await http.post(
      Uri.parse("http://192.168.2.159:8080/FlutterAPI/deleteLocationList.php"),
      body: {
        "location_name": locationNames
      },
    );
    print(respns.body);
    var jsonDatas = json.decode(respns.body);
    return jsonDatas;
  }
}
