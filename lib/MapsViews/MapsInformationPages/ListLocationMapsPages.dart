import 'package:absent_project/MapsViews/MapControllerPages/LocationControllersPages.dart';
import 'package:absent_project/MapsViews/MapsInformationPages/DetailLocations.dart';
import 'package:absent_project/MapsViews/MapsInformationPages/locationListControllers.dart';
import 'package:absent_project/MapsViews/MapsViewPage/GoogleMapsPages.dart';
import 'package:absent_project/home/ApplicationBar.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class listLocationsMaps extends StatefulWidget {
  const listLocationsMaps({super.key});

  @override
  State<listLocationsMaps> createState() => _listLocationsMapsState();
}

class _listLocationsMapsState extends State<listLocationsMaps> {
  listLocationsContollers locationControllers = listLocationsContollers();
  List<dynamic> locations = [];
  var faker = new Faker();
  bool settingEnabled = true;

  Future<void> viewLocation() async {
    var viewsLocations = await locationControllers.getListLocations();
    setState(() {
      locations = viewsLocations ?? [];
      settingEnabled = locations.isEmpty;
    });
  }

  Future<void> deleteListLocations(String locationNames) async {
    var resp = await listLocationsContollers().deleteLocation(locationNames as String);
    if (resp['success']) {
      await viewLocation();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resp['message']))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete location"))
      );
    }
  }

  @override
  void initState() {
    super.initState();
    viewLocation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 147, 195, 234),
                        Color.fromARGB(255, 98, 171, 232),
                        Color.fromARGB(255, 123, 185, 235),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(34),
                      bottomRight: Radius.circular(34),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 48,
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
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: Icon(Icons.search_rounded),
                          prefixIcon: IconButton(
                              onPressed: (){
                                _showConfirmDialog(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                              )
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: locationControllers.getListLocations(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator()
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Error loading locations",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.red)
                        )
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No locations found.", style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, int index) {
                        var locationViews = snapshot.data![index];
                        return Slidable(
                          key: ValueKey(locationViews.locationsNames),
                          endActionPane: ActionPane(
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: "Delete",
                                onPressed: (context) => deleteListLocations(locationViews.locationsNames),
                              ),
                            ],
                          ),
                          child: ListTile(
                            subtitle: Text(locationViews.streetNames),
                            title: Text(locationViews.locationsNames),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(locationViews.locationImg),
                            ),
                            onTap: () {
                              Get.to(() => detailLocatiosMaps(listLocationMaps: locationViews));
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => googleMapsPages()),
                );
              },
              backgroundColor: Colors.blueAccent,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: null,
              onPressed: settingEnabled ? null : () {
                Get.offAll(locationsControllersPages());
              },
              backgroundColor: settingEnabled ? Colors.grey : Colors.blueAccent,
              child: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ],
        ),
      )
    );
  }

  Future<Future<bool?>> _showConfirmDialog(BuildContext context) async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Icon(Icons.warning_amber,
                color: Colors.deepOrange),
            title: Text(
              "Attentions!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text("ARE YOU SURE WANT TO EXIT"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("NO",style:
                TextStyle(color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(onPressed: (){
                Get.offAll(() => ApplicationBar());
                //ctr_data().clear_maps_func();
              },
                child:Text("YES",style:
                TextStyle(color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }
    );
  }
}
