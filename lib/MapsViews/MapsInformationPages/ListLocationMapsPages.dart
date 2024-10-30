import 'package:absent_project/MapsViews/MapsInformationPages/locationListControllers.dart';
import 'package:absent_project/MapsViews/MapsViewPage/GoogleMapsPages.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class listLocationsMaps extends StatefulWidget {
  const listLocationsMaps({super.key});

  @override
  State<listLocationsMaps> createState() => _listLocationsMapsState();
}

class _listLocationsMapsState extends State<listLocationsMaps> {

  listLocationsContollers locationControllers = listLocationsContollers();
  List<dynamic> locations = [];
  var faker = new Faker();

  Future<void> viewLocation() async {
    var viewsLocations = await locationControllers.getListLocations();
    setState(() {
      locations = viewsLocations ?? [];
    });
  }

  Future<void> deleteListLocations(String locationNames) async {
    var resp = await listLocationsContollers().deleteLocation(locationNames as String);
    if (resp['success']) {
      await viewLocation();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              resp['message']
            )
        )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              "Failed Delete User"
            )
        )
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
    const rowSpacer = TableRow(
      children: [
        SizedBox(height: 8),
        SizedBox(height: 8),
      ],
    );

    return Scaffold(
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
                    ),
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: locationControllers.getListLocations(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error loading users"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No users found"));
              } else {
                return Expanded(
                  child: ListView.builder(
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
                            backgroundImage: NetworkImage(
                              locationViews.locationImg
                            ),
                          ),
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => googleMapsPages()),
          );
        },
        backgroundColor: Color.fromARGB(255, 139, 190, 232),
        child: const Icon(Icons.add),
      ),
    );
  }
}
