import 'dart:async';
import 'package:absent_project/MapsViews/MatterialMaps/FindMapLocationControllers.dart';
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

  static const LatLng _googleView = LatLng(
      -6.200000,
      106.816666
  );

  void mapsCreateds(GoogleMapController controllers) async {
    final findCoordinates = await coordinateLocation();
    mapControllers = controllers;

    if (mounted) {
      setState(() {
        initMarkerLocation.add(
          Marker(
              markerId: MarkerId("locations"),
              position: findCoordinates,
              infoWindow: InfoWindow(
                title: "location Project"
              )
          )
        );
      });
    }
  }

  void radiusPosition() async {

    final findRadiusPosition = await findRadiusLocation();
    final locationPosition = await coordinateLocation();

    if (findRadiusPosition != null) {

      if (mounted) {
          setState(() {
            circless = {
              Circle(
                circleId: CircleId('radiusPosition'),
                center: locationPosition,
                radius: findRadiusPosition,
                strokeColor: Colors.blueAccent,
                strokeWidth: 1,
                fillColor: Color.fromARGB(255, 147, 195, 234).withOpacity(0.6),
              )
            };
          });
      }
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
            print(currentPosition);
          });
        }
      }
    });
  }
}
