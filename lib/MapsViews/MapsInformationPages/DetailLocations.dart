import 'package:absent_project/MapsViews/MapsInformationPages/locationList.dart';
import 'package:flutter/material.dart';

class detailLocatiosMaps extends StatelessWidget {
  final listLocations listLocationMaps;
  detailLocatiosMaps({
     super.key, required this.listLocationMaps
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text(
              listLocationMaps.locationsNames,
              style: const TextStyle(fontSize: 15),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 147, 195, 234),
                  Color.fromARGB(255, 98, 171, 232),
                  Color.fromARGB(255, 123, 185, 235),
                ]),
              ),
            ),
            elevation: 0,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [ Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                              )
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(listLocationMaps.locationImg),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 4, color: Colors.white),
                              color: Colors.blue,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  itemProfile('Location Name', listLocationMaps.locationsNames),
                  const SizedBox(height: 10),
                  itemProfile('Street', listLocationMaps.streetNames),
                  const SizedBox(height: 10),
                  itemProfile('Locality Name', listLocationMaps.localityNames),
                  const SizedBox(height: 10),
                  itemProfile('SubLocality Name', listLocationMaps.sublocalityNames),
                  const SizedBox(height: 30),
                  const Text(
                    "CITY LOCATIONS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  itemProfile('City Names', listLocationMaps.cityNames),
                  const SizedBox(height: 10),
                  itemProfile('SubCity Names', listLocationMaps.subcityNames),
                  const SizedBox(height: 20),
                  itemProfile('Postal Code', listLocationMaps.postalCodeNumber),
                  const SizedBox(height: 30),
                  const Text(
                    "COORDINATE LOCATION",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  itemProfile('Radius Location', listLocationMaps.radiusLocation),
                  const SizedBox(height: 20),
                  itemProfile('Latitude Location', listLocationMaps.latitudeLocations),
                  const SizedBox(height: 20),
                  itemProfile('Longtitude Location', listLocationMaps.longtitudeLocations),
                 ],
               ),
              ],
            ),
          ),

    );
  }

  Widget itemProfile(String title, String subtitle) {
    return GestureDetector(
      onTap: () {
        /*openDialog();*/
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: const Color.fromARGB(255, 144, 200, 245).withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 10,
            )
          ],
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
          tileColor: Colors.white,
        ),
      ),
    );
  }
}
