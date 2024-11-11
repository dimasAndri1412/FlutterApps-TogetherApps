import 'dart:convert';
import 'package:http/http.dart' as http;

class insertAddressLocationControllers {
  String? projectNamesAddrController, locationNamesAddrController;
  var addrLoctionUsers;

  Future insertAddrLocations() async {

    try{

      var insrtAddrLocValues = Uri.parse("http://192.168.2.159:8080/FlutterAPI/insert_address_and_location_controllers_new.php");
      var resp = await http.post(
          insrtAddrLocValues,
          body: {
            "project_name" : projectNamesAddrController,
            "location_name" : locationNamesAddrController
          }
      );
      addrLoctionUsers = jsonDecode(resp.body);
    } catch (err) {
      print(err);
      return err;
    }
  }
}