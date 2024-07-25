//import 'package:absent_project/MapsViews/MapsViewPage/GoogleMapsSaveButtons.dart';
import 'package:absent_project/MapsViews/MapsViewPage/GoogleMapsButtons.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';

class googleMapsField extends StatefulWidget {
  const googleMapsField({super.key});

  @override
  State<googleMapsField> createState() => _googleMapsFieldState();
}

class _googleMapsFieldState extends State<googleMapsField> {

  String dropDownValues = "";

  @override
  void initState() {
    super.initState();
    dropDownValues = "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Form(
            key: GoogleMapsForm,
            child: Column(
              children: <Widget>[
                Center(
                  child: Icon(
                    Icons.linear_scale,
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "DETAIL LOCATIONS",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black87
                          )
                      )
                  ),
                  child: TextFormField(
                    controller: nameLocationController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Location Name",
                      hintText: "Location Name",
                      hintStyle: TextStyle(
                        color: Colors.black12,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                          Icons.home
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " Location Name can not empty";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black87
                          )
                      )
                  ),
                  child: TextFormField(
                    controller: StreetLocationController,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Street",
                        hintText: "Street",
                        hintStyle: TextStyle(
                          color: Colors.black12,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                            Icons.streetview
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Street can not empty";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black87
                          )
                      )
                  ),
                  child: TextFormField(
                    controller: localityLocationController,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Locality",
                        hintText: "Locality",
                        hintStyle: TextStyle(
                          color: Colors.black12,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                            Icons.location_city_rounded
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Locality can not empty";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black87
                          )
                      )
                  ),
                  child: TextFormField(
                    controller: SubLocalityLocationController,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "SubLocality",
                        hintText: "SubLocality",
                        hintStyle: TextStyle(
                          color: Colors.black12,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                            Icons.location_city_rounded
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Sublocality can not empty";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black87
                          )
                      )
                  ),
                  child: TextFormField(
                    controller: stateLocationController,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "City",
                        hintText: "City",
                        hintStyle: TextStyle(
                          color: Colors.black12,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                            Icons.maps_home_work
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "City Can not Empty";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black87
                          )
                      )
                  ),
                  child: TextFormField(
                    controller: subStateLocationController,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Sub City",
                        hintText: "Sub City",
                        hintStyle: TextStyle(
                          color: Colors.black12,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                            Icons.maps_home_work
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Sub City Can not empty";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black87
                          )
                      )
                  ),
                  child: TextFormField(
                    controller: postalCodeController,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Postal Code",
                        hintText: "Postal Code",
                        hintStyle: TextStyle(
                          color: Colors.black12,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                            Icons.post_add
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Postal Code Can not Empty";
                      }
                    },
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border:
                        Border(bottom: BorderSide(color: Colors.black87))),
                    child: DropdownButtonFormField<String>(
                      value: dropDownValues,
                      items: [
                        DropdownMenuItem(
                            child: Text(
                              "--Selected Radius Distance--",
                              style: TextStyle(color: Colors.black26),
                            ),
                            value: ""),
                        DropdownMenuItem(
                          child: Text("100 Meter"),
                          value: "100",
                        ),
                        DropdownMenuItem(
                          child: Text("200 Meter"),
                          value: "200",
                        ),
                        DropdownMenuItem(
                          child: Text("300 Meter"),
                          value: "300",
                        ),
                        DropdownMenuItem(
                          child: Text("400 Meter"),
                          value: "400",
                        ),
                        DropdownMenuItem(
                          child: Text("500 Meter"),
                          value: "500",
                        ),
                        DropdownMenuItem(
                          child: Text("600 Meter"),
                          value: "600",
                        ),
                        DropdownMenuItem(
                          child: Text("700 Meter"),
                          value: "700",
                        ),
                        DropdownMenuItem(
                          child: Text("800 Meter"),
                          value: "800",
                        ),
                        DropdownMenuItem(
                          child: Text("900 Meter"),
                          value: "900",
                        ),
                        DropdownMenuItem(
                          child: Text("1000 Meter"),
                          value: "1000",
                        ),
                      ],
                      decoration: InputDecoration(
                          border: InputBorder.none, prefixIcon: Icon(Icons.radar_rounded)),
                      onChanged: (value) {
                        setState(() {
                          dropDownValues = value!;
                          if (value.isNotEmpty) {
                            radiusController.text = value;
                          } else {
                            radiusController.clear();
                          }
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Select Project";
                        }
                        return null;
                      },
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black87
                          )
                      )
                  ),
                  child: TextFormField(
                    controller: radiusController,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Radius Location",
                        hintText: "Radius Location",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                            Icons.radar_sharp
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Distance Radius Can not Empty";
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 170,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black
                                  ),
                                ),
                              ),
                              child: TextFormField(
                                controller: latitudeLocationController,
                                readOnly: true,
                                decoration: InputDecoration(
                                    labelText: "Latitude",
                                    hintText: "Latitude",
                                    hintStyle: TextStyle(
                                      color: Colors.black12,
                                    ),
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                        Icons.location_pin
                                    )
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Latitude can not empty";
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 170,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black
                                      )
                                  )
                              ),
                              child: TextFormField(
                                controller: longtitudeLocationController,
                                readOnly: true,
                                decoration: InputDecoration(
                                    labelText: "LongTitude",
                                    hintText: "LongTitude",
                                    hintStyle: TextStyle(
                                      color: Colors.black12,
                                    ),
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                        Icons.location_pin
                                    )
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Longtitude can not empty";
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                googleMapsButtons()
              ],
            )
        )
      ],
    );
  }
}
