import 'dart:convert';

import 'package:absent_project/controller/Keys.dart';
import 'package:http/http.dart' as http;

class insertAddressLocationController {
  String? locationName,streetLocation,localityLocation,subLocalityLocation,
          cityLocation,subCityLocation,postalCodeLocation,radiusLocation,
          latiTudeLocation,longTitudeLocation;

  var AddressLocation;
  
  Future insertToLocationAddress() async{
    String locationsNamesInput = nameLocationController.text;
    String streetInputs = StreetLocationController.text;
    String localityInput = localityLocationController.text;
    String subLocalityInput = SubLocalityLocationController.text;
    String cityInputs = stateLocationController.text;
    String subcityInputs = subStateLocationController.text;
    String postalCodeInput = postalCodeController.text;
    String radiusInput = radiusController.text;
    String latitudeInput = latitudeLocationController.text;
    String longtitudeInput = longtitudeLocationController.text;
    
    try {
      
      var locationUrl = Uri.parse("http://192.168.100.204/FlutterAPI/insert_Location.php");
      var resp = await http.post(
        locationUrl,
        body: {
          'location_name' : locationsNamesInput,
          'street' : streetInputs,
          'locality' : localityInput,
          'sublocality' : subLocalityInput,
          'city' : cityInputs,
          'subcity' : subcityInputs,
          'postal_code' : postalCodeInput,
          'radius' : radiusInput,
          'latitude' : latitudeInput,
          'longtitude' : longtitudeInput
        }
      );

      AddressLocation = jsonDecode(resp.body);
      
    } catch (exeception) {
      return "can not insert location";
    }
  }
}