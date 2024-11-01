import 'package:absent_project/MapsViews/MapsViewPage/GoogleMapsViews.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../../controller/Keys.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class googleMapsWrapper extends StatefulWidget {
  const googleMapsWrapper({super.key});

  @override
  State<googleMapsWrapper> createState() => _googleMapsWrapper();

}

class _googleMapsWrapper extends State<googleMapsWrapper> {

  Marker? _currentMarker;
  GoogleMapController? mapControllers;

  Future<void> SearchLocation() async {
    String query = SearchLocationController.text;

    if (query.isNotEmpty) {

      try {
        List<Location> locations = await locationFromAddress(query);
        if (locations.isNotEmpty) {

          Location location = locations.first;
          LatLng positions = LatLng(
              location.latitude,
              location.longitude
          );

          newPositionNotfier.value = positions;

          mapControllers?.animateCamera(CameraUpdate.newLatLng(positions));

          latitudeLocationController.text = location.latitude.toString();
          longtitudeLocationController.text = location.longitude.toString();

          //Address full
          List<Placemark>placeMrks = await placemarkFromCoordinates(
              location.latitude,
              location.longitude
          );

          String addressMrk = placeMrks.isNotEmpty
              ? '${placeMrks.first.street}, ${placeMrks.first.locality}, ${placeMrks.first.country}'
              : 'Address is not found';

          stateLocationController.text = placeMrks.first.administrativeArea.toString();
          subStateLocationController.text = placeMrks.first.subAdministrativeArea.toString();
          localityLocationController.text = placeMrks.first.locality.toString();
          SubLocalityLocationController.text = placeMrks.first.subLocality.toString();
          StreetLocationController.text = placeMrks.first.street.toString();
          nameLocationController.text = SearchLocationController.text;
          postalCodeController.text = placeMrks.first.postalCode.toString();

          print(placeMrks);

          setState(() {
            if (_currentMarker == null) {
              _currentMarker = Marker(
                  markerId: MarkerId("currentLocation"),
                  position: positions,
                  infoWindow: InfoWindow(
                      title: query,
                      snippet: addressMrk
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue)
              );

              initMarkers.add(_currentMarker!);

            } else {
              initMarkers.remove(_currentMarker);
              _currentMarker = _currentMarker!.copyWith(
                positionParam: positions,
                infoWindowParam: InfoWindow(
                    title: query,
                    snippet: addressMrk
                ),
              );
              initMarkers.add(_currentMarker!);
            }
          });
        }
      } catch (err) {
        print('Error occured while searching location: $err');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[

              Form(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 147, 195, 234),
                                Color.fromARGB(255, 98, 171, 232),
                                Color.fromARGB(255, 123, 185, 235),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 20,
                                offset: Offset(2, 10),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(26),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: Color.fromARGB(255, 246, 178, 198).withOpacity(0.23),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: SearchLocationController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                                hintText: "SELECTED LOCATION",
                                hintStyle: TextStyle(
                                  color: Colors.black12,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios_sharp),
                                  onPressed: SearchLocation,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: googleMapsViews(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}