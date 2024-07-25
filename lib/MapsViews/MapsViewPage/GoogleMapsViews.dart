import 'package:absent_project/MapsViews/MapsViewPage/GoogleMapsFields.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class googleMapsViews extends StatefulWidget {
  const googleMapsViews({super.key});

  @override
  State<googleMapsViews> createState() => _googleMapsViewsState();

}

class _googleMapsViewsState extends State<googleMapsViews> {

  GoogleMapController? mapControllers;

  static const LatLng _googleView = LatLng(
      -6.200000,
      106.816666
  );

  void onMapCreated(GoogleMapController controller) async{
    mapControllers = controller;
    if (mounted) {
      setState(() {
        initMarkers.remove(
          Marker(
            markerId: MarkerId("_initialLocation"),
            position: _googleView,
            infoWindow: InfoWindow(title: "Jakarta"),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUpdateLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FractionallySizedBox(
            heightFactor: 0.90,
            child: currentPosition == null ?
            const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 147, 195, 234),
              ),
            )
                : GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                  target: currentPosition!,
                  zoom: 11.0
              ),
              markers: initMarkers,
              onCameraMove: null,
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.25,
            minChildSize: 0.11,
            maxChildSize: 0.75,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25.0),
                      topLeft: Radius.circular(25.0),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 20.0
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: googleMapsField(),
                    ),
                  )
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> fetchUpdateLocation() async{
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationController.onLocationChanged.listen((LocationData currentLocation) {

      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        if (mounted) {
          setState(() {
            currentPosition = LatLng(
                currentLocation.latitude!,
                currentLocation.longitude!
            );
            print(currentPosition);
          });
        }
      }
    });
  }
}
