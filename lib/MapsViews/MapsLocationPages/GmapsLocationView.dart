import 'dart:async';
import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class GmapsViews extends StatefulWidget {
  const GmapsViews({super.key});

  @override
  State<GmapsViews> createState() => _GmapsViewsState();
}

class _GmapsViewsState extends State<GmapsViews> {

  GoogleMapController? mapControllers;

  void mapsCreateds(GoogleMapController controllers) async {
    final findCoordinates = await coordinateLocatioNew();
    mapControllers = controllers;

    if (mounted) {
      setState(() {
        for (var coord  in findCoordinates) {
          initMarkerLocation.add(
            Marker(
                markerId: MarkerId(coord.toString()),
                position: coord,
                infoWindow: InfoWindow(
                  title: "Locations Project"
                )
            )
          );
        }
      });
    }
  }

  void radiusPosition() async {

    final findradius = await findRadiusLocationNew();

    if(mounted) {

      setState(() {
        circless = {
          for (var location in findradius)
            Circle(
                circleId: CircleId(
                  location["coordinate"].toString(),
                ),
              center: location["coordinate"],
              radius: location["radius"],
              strokeColor: Colors.blueAccent,
              strokeWidth: 1,
              fillColor: Color.fromARGB(255, 147, 195, 234).withOpacity(0.6)
            )
        };
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUpdateLocation();
    radiusPosition();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPosition == null?
      const Center(
        child: CircularProgressIndicator(
          color: Colors.lightBlue,
          backgroundColor: Color.fromARGB(254, 147, 195, 234),
        ),
      )
          : GoogleMap(
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        onMapCreated: mapsCreateds,
        initialCameraPosition: CameraPosition(
            target: currentPosition!,
            zoom: 17.0
        ),
        markers: initMarkerLocation,
        onCameraMove: null,
        circles: circless,
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
          });
        }
      }
    });
  }
}